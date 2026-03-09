#!/usr/bin/env bash
set -euo pipefail

DAVAI_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$DAVAI_DIR/davai.config.yml"
CORE_INSTRUCTIONS="$DAVAI_DIR/core/ceo-instructions.md"

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

# Update config: set active tool
sed -i '' "s/^tool: .*/tool: ${TOOL}/" "$CONFIG_FILE"

# Clean up previous setup
rm -f "$DAVAI_DIR/CLAUDE.md"
rm -f "$DAVAI_DIR/.cursorrules"
rm -rf "$DAVAI_DIR/.cursor/rules/davai-ceo.mdc"

# Generate instructions for the chosen tool
case "$TOOL" in
    claude-code)
        cp "$CORE_INSTRUCTIONS" "$DAVAI_DIR/CLAUDE.md"
        echo -e "  ${GREEN}+${NC} Created CLAUDE.md"
        ;;

    cursor)
        # Ensure .cursor/rules/ exists
        mkdir -p "$DAVAI_DIR/.cursor/rules"

        # Generate .mdc file with frontmatter
        cat > "$DAVAI_DIR/.cursor/rules/davai-ceo.mdc" <<MDCEOF
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
GITIGNORE="$DAVAI_DIR/.gitignore"

# Ensure generated instruction files are gitignored (they're generated from core/)
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
