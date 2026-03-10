#!/usr/bin/env bash
# Non-interactive auto-update for Davai framework.
# Checks remote for updates, pulls if behind, refreshes installed/ from framework/.
# Safe to run anytime — never interactive, all failures exit 0.

set -euo pipefail

FRAMEWORK_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$FRAMEWORK_DIR")"
INSTALLED_DIR="$ROOT_DIR/installed"

# --- Guard checks ---

# Not set up yet — nothing to update
if [ ! -f "$INSTALLED_DIR/config.yml" ]; then
    exit 0
fi

TOOL=$(grep '^tool:' "$INSTALLED_DIR/config.yml" 2>/dev/null | sed 's/tool: *//' || echo "null")
if [ "$TOOL" = "null" ] || [ -z "$TOOL" ]; then
    exit 0
fi

# Map tool to display name
case "$TOOL" in
    claude-code) AI_TOOL_NAME="Claude Code" ;;
    cursor)      AI_TOOL_NAME="Cursor" ;;
    *)           exit 0 ;;
esac

# --- Check for updates ---

# Fetch with timeout (skip if offline or no remote)
if ! timeout 5 git -C "$ROOT_DIR" fetch origin --quiet 2>/dev/null; then
    exit 0
fi

LOCAL=$(git -C "$ROOT_DIR" rev-parse HEAD 2>/dev/null || exit 0)
REMOTE=$(git -C "$ROOT_DIR" rev-parse "@{u}" 2>/dev/null || exit 0)
BASE=$(git -C "$ROOT_DIR" merge-base HEAD "@{u}" 2>/dev/null || exit 0)

# Already up to date
if [ "$LOCAL" = "$REMOTE" ]; then
    exit 0
fi

# Local is ahead or diverged — don't touch
if [ "$LOCAL" != "$BASE" ]; then
    echo "Davai: local changes detected, skipping auto-update."
    exit 0
fi

# --- Pull changes ---

if ! git -C "$ROOT_DIR" pull --ff-only --quiet 2>/dev/null; then
    echo "Davai: could not auto-update (conflict or dirty tree). Run 'git pull' manually."
    exit 0
fi

# --- Refresh installed/ from framework/ ---

# Remove generated parts (preserve user data: learnings.md, drafts/, projects/)
rm -rf "$INSTALLED_DIR/agents" \
       "$INSTALLED_DIR/templates" \
       "$INSTALLED_DIR/library" \
       "$INSTALLED_DIR/config.yml"

# Copy framework files
cp -R "$FRAMEWORK_DIR/agents" "$INSTALLED_DIR/agents"
cp -R "$FRAMEWORK_DIR/templates" "$INSTALLED_DIR/templates"
cp -R "$FRAMEWORK_DIR/library" "$INSTALLED_DIR/library"
cp "$FRAMEWORK_DIR/config.yml" "$INSTALLED_DIR/config.yml"

# Set active tool in config
tmp=$(mktemp)
sed "s/^tool: .*/tool: ${TOOL}/" "$INSTALLED_DIR/config.yml" > "$tmp" && mv "$tmp" "$INSTALLED_DIR/config.yml"

# Replace {{ai_tool}} in generated files
for dir in agents templates library; do
    find "$INSTALLED_DIR/$dir" -type f \( -name '*.md' -o -name '*.yml' \) -exec \
        sed -i.bak "s/{{ai_tool}}/${AI_TOOL_NAME}/g" {} +
done
find "$INSTALLED_DIR" -name '*.bak' -delete

# Regenerate CEO instructions file
CEO_CONTENT=$(sed "s/{{ai_tool}}/${AI_TOOL_NAME}/g" "$FRAMEWORK_DIR/core/ceo-instructions.md")

case "$TOOL" in
    claude-code)
        echo "$CEO_CONTENT" > "$ROOT_DIR/CLAUDE.md"
        ;;
    cursor)
        mkdir -p "$ROOT_DIR/.cursor/rules"
        cat > "$ROOT_DIR/.cursor/rules/davai-ceo.mdc" <<MDCEOF
---
description: Davai CEO — orchestrator that guides from idea to project
alwaysApply: true
---

${CEO_CONTENT}
MDCEOF
        ;;
esac

SHORT_HASH=$(git -C "$ROOT_DIR" rev-parse --short HEAD 2>/dev/null || echo "unknown")
echo "Davai: framework updated to ${SHORT_HASH}."
