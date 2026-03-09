#!/usr/bin/env bash
set -euo pipefail

# Framework lives in framework/, project root is one level up
FRAMEWORK_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$FRAMEWORK_DIR")"
CONFIG_FILE="$FRAMEWORK_DIR/config.yml"
CORE_INSTRUCTIONS="$FRAMEWORK_DIR/core/ceo-instructions.md"

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
CURRENT_TOOL=$(grep '^tool:' "$CONFIG_FILE" 2>/dev/null | sed 's/tool: *//' || echo "null")
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

# Choose tool
echo -e "  Which AI tool will you use with davai?"
echo ""
echo -e "    ${BOLD}1)${NC} Claude Code"
echo -e "    ${BOLD}2)${NC} Cursor"
echo ""
read -rp "  Your choice (1/2): " CHOICE

case "$CHOICE" in
    1) TOOL="claude-code" ;;
    2) TOOL="cursor" ;;
    *)
        echo -e "\n  ${RED}Invalid choice.${NC}\n"
        exit 1
        ;;
esac

echo ""
echo -e "  Setting up davai for ${CYAN}${TOOL}${NC}..."

# Update config: set active tool (portable sed — works on macOS and Linux)
tmp=$(mktemp)
sed "s/^tool: .*/tool: ${TOOL}/" "$CONFIG_FILE" > "$tmp" && mv "$tmp" "$CONFIG_FILE"

# Clean up previous setup (in project root)
rm -f "$ROOT_DIR/CLAUDE.md"
rm -f "$ROOT_DIR/.cursorrules"
rm -rf "$ROOT_DIR/.cursor/rules/davai-ceo.mdc"

# Generate instructions for the chosen tool (in project root)
case "$TOOL" in
    claude-code)
        cp "$CORE_INSTRUCTIONS" "$ROOT_DIR/CLAUDE.md"
        echo -e "  ${GREEN}+${NC} Created CLAUDE.md"
        ;;

    cursor)
        mkdir -p "$ROOT_DIR/.cursor/rules"

        cat > "$ROOT_DIR/.cursor/rules/davai-ceo.mdc" <<MDCEOF
---
description: davai CEO — orchestrator that guides from idea to project
alwaysApply: true
---

$(cat "$CORE_INSTRUCTIONS")
MDCEOF
        echo -e "  ${GREEN}+${NC} Created .cursor/rules/davai-ceo.mdc"
        ;;
esac

# Update .gitignore
GITIGNORE="$ROOT_DIR/.gitignore"

declare -a IGNORE_ENTRIES=(
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
echo -e "  ${GREEN}Done!${NC} davai is ready for ${CYAN}${TOOL}${NC}."
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
