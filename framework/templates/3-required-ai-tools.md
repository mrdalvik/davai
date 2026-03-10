# Required AI Tools: <Product Name>

## Prerequisites (user action required)
What the user needs to prepare before development starts:
- API keys, tokens, accounts
- ...

## Library Skills (copy from library/skills/)

| Skill | Directory | Why |
|-------|-----------|-----|
| ... | `library/skills/<name>/` | ... |

## Custom Skills (create new)

Each skill uses SKILL.md format with frontmatter. Created using skill-creator methodology with docs researched via Context7.

### <skill-name>/SKILL.md
```markdown
---
name: skill-name
description: "When and why to use this skill. Be specific and slightly pushy — include trigger contexts and keywords."
---

Skill instructions here...
Use up-to-date API patterns (verified via Context7 or docs).
```

**Docs source**: Context7 (`resolve-library-id` → `query-docs`) / WebSearch / "verify before use"

## MCP Servers (from library/mcp/ or external)

| MCP Server | Source | Purpose | Verified? |
|------------|--------|---------|-----------|
| context7 | `npx -y @upstash/context7-mcp` | Up-to-date library/framework docs for LLM | yes — recommended for all projects |
| ... | `library/mcp/<name>/` or external | ... | yes/no — check before installing |

## CLI Tools

| Tool | Purpose | Install |
|------|---------|---------|
| ... | ... | ... |

## Project Instructions Recommendations
Key points to include in the project's instructions file:
- ...
