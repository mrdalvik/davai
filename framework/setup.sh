#!/usr/bin/env bash
set -euo pipefail

# Framework lives in framework/, project root is one level up
FRAMEWORK_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$FRAMEWORK_DIR")"
INSTALLED_DIR="$ROOT_DIR/installed"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${BOLD}  davai${NC} — from idea to project"
echo -e "  ──────────────────────────────"
echo ""

# Check if already configured
if [ -f "$INSTALLED_DIR/config.yml" ]; then
    CURRENT_TOOL=$(grep '^tool:' "$INSTALLED_DIR/config.yml" 2>/dev/null | sed 's/tool: *//' || echo "null")
    if [ "$CURRENT_TOOL" != "null" ] && [ -n "$CURRENT_TOOL" ]; then
        echo -e "  Currently configured for: ${CYAN}${CURRENT_TOOL}${NC}"
        echo ""
        read -rp "  Reconfigure? (y/N): " RECONFIGURE
        if [[ ! "$RECONFIGURE" =~ ^[Yy]$ ]]; then
            echo -e "\n  ${GREEN}Nothing changed.${NC}\n"
            exit 0
        fi
        echo ""
    fi
fi

# Choose tool
echo -e "  Which AI tool will you use with davai?"
echo ""
echo -e "    ${BOLD}1)${NC} Claude Code"
echo -e "    ${BOLD}2)${NC} Cursor"
echo ""
read -rp "  Your choice (1/2): " CHOICE

case "$CHOICE" in
    1)
        TOOL="claude-code"
        AI_TOOL_NAME="Claude Code"
        ;;
    2)
        TOOL="cursor"
        AI_TOOL_NAME="Cursor"
        ;;
    *)
        echo -e "\n  ${RED}Invalid choice.${NC}\n"
        exit 1
        ;;
esac

echo ""
echo -e "  Setting up davai for ${CYAN}${AI_TOOL_NAME}${NC}..."

# --- Build installed/ from framework/ ---

# Validate framework files exist
for dir in agents templates skills-library; do
    if [ ! -d "$FRAMEWORK_DIR/$dir" ]; then
        echo -e "\n  ${RED}Missing framework/$dir — framework files are incomplete.${NC}\n"
        exit 1
    fi
done
if [ ! -f "$FRAMEWORK_DIR/config.yml" ] || [ ! -f "$FRAMEWORK_DIR/core/ceo-instructions.md" ]; then
    echo -e "\n  ${RED}Missing framework files — config.yml or core/ceo-instructions.md not found.${NC}\n"
    exit 1
fi

mkdir -p "$INSTALLED_DIR"

# Remove only generated parts (preserve user data: learnings.md, drafts/, projects/)
rm -rf "$INSTALLED_DIR/agents" \
       "$INSTALLED_DIR/templates" \
       "$INSTALLED_DIR/skills-library" \
       "$INSTALLED_DIR/config.yml"

# Copy framework files
cp -R "$FRAMEWORK_DIR/agents" "$INSTALLED_DIR/agents"
cp -R "$FRAMEWORK_DIR/templates" "$INSTALLED_DIR/templates"
cp -R "$FRAMEWORK_DIR/skills-library" "$INSTALLED_DIR/skills-library"
cp "$FRAMEWORK_DIR/config.yml" "$INSTALLED_DIR/config.yml"

# Create user data files if they don't exist
if [ ! -f "$INSTALLED_DIR/learnings.md" ]; then
    cat > "$INSTALLED_DIR/learnings.md" <<'LEARNEOF'
# Learnings

Project insights accumulated over time. Read this before making recommendations for new projects.

Each entry follows a structured format — see CEO instructions (Learnings Format section) for the schema.
LEARNEOF
    echo -e "  ${GREEN}+${NC} Created learnings.md"
fi

mkdir -p "$INSTALLED_DIR/drafts"
mkdir -p "$INSTALLED_DIR/projects"

echo -e "  ${GREEN}+${NC} Built installed/ from framework/"

# --- Replace variables in installed/ ---

# Set active tool in config
tmp=$(mktemp)
sed "s/^tool: .*/tool: ${TOOL}/" "$INSTALLED_DIR/config.yml" > "$tmp" && mv "$tmp" "$INSTALLED_DIR/config.yml"

# Replace {{ai_tool}} in all generated .md and .yml files (skip user data)
for dir in agents templates skills-library; do
    find "$INSTALLED_DIR/$dir" -type f \( -name '*.md' -o -name '*.yml' \) -exec \
        sed -i.bak "s/{{ai_tool}}/${AI_TOOL_NAME}/g" {} +
done

# Clean up .bak files
find "$INSTALLED_DIR" -name '*.bak' -delete

echo -e "  ${GREEN}+${NC} Replaced variables ({{ai_tool}} → ${AI_TOOL_NAME})"

# --- Generate tool-specific instruction file in project root ---

# Build CEO instructions with variable substitution (directly from framework/core/)
CEO_CONTENT=$(sed "s/{{ai_tool}}/${AI_TOOL_NAME}/g" "$FRAMEWORK_DIR/core/ceo-instructions.md")

# Clean up bootstrap and previous instruction files
rm -f "$ROOT_DIR/CLAUDE.md"
rm -f "$ROOT_DIR/.cursorrules"
rm -rf "$ROOT_DIR/.cursor/rules/davai-bootstrap.mdc"
rm -rf "$ROOT_DIR/.cursor/rules/davai-ceo.mdc"

case "$TOOL" in
    claude-code)
        echo "$CEO_CONTENT" > "$ROOT_DIR/CLAUDE.md"
        echo -e "  ${GREEN}+${NC} Created CLAUDE.md"
        ;;

    cursor)
        mkdir -p "$ROOT_DIR/.cursor/rules"

        cat > "$ROOT_DIR/.cursor/rules/davai-ceo.mdc" <<MDCEOF
---
description: davai CEO — orchestrator that guides from idea to project
alwaysApply: true
---

${CEO_CONTENT}
MDCEOF
        echo -e "  ${GREEN}+${NC} Created .cursor/rules/davai-ceo.mdc"
        ;;
esac

# --- Update .gitignore ---

GITIGNORE="$ROOT_DIR/.gitignore"

declare -a IGNORE_ENTRIES=(
    "installed/"
    "CLAUDE.md"
    ".cursor/"
    ".cursorrules"
)

for entry in "${IGNORE_ENTRIES[@]}"; do
    if ! grep -qxF "$entry" "$GITIGNORE" 2>/dev/null; then
        echo "$entry" >> "$GITIGNORE"
    fi
done

echo -e "  ${GREEN}+${NC} Updated .gitignore"

echo ""
echo -e "  ${GREEN}Done!${NC} davai is ready for ${CYAN}${AI_TOOL_NAME}${NC}."
echo ""

case "$TOOL" in
    claude-code)
        echo -e "  Next: run ${BOLD}claude${NC} in this directory to start."
        ;;
    cursor)
        echo -e "  Next: open this folder in ${BOLD}Cursor${NC} to start."
        ;;
esac

echo ""
