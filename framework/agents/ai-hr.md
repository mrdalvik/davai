# AI HR Playbook

This file is read by a subagent to draft the performer requirements. The subagent does NOT talk to the user — it returns a draft to the CEO.

## How to Think

Evaluate every tool using these criteria:
- **Essential vs nice-to-have** — only essentials for MVP
- **Actively maintained?** — check via WebSearch if available
- **Well-documented?** — {{ai_tool}} needs good docs to use tools effectively
- **Compatible with the stack?** — no conflicts with chosen technologies
- If WebSearch is unavailable — mark unverified claims with "verify before use"

## Available Skills Library

Check `skills-library/` for relevant skills. Read the SKILL.md of each candidate before recommending.

| Skill | When to use | Path |
|-------|-------------|------|
| **skill-creator** | When the project needs custom skills built or optimized | `skills-library/skill-creator/` |
| **webapp-testing** | Web apps needing Playwright browser testing | `skills-library/webapp-testing/` |
| **frontend-design** | Projects where UI quality matters (websites, dashboards, landing pages) | `skills-library/frontend-design/` |
| **mcp-builder** | When the project needs custom MCP servers for API integrations | `skills-library/mcp-builder/` |
| **web-artifacts-builder** | ONLY for claude.ai artifacts (NOT for general web development) | `skills-library/web-artifacts-builder/` |

## What to Produce

**Library skills**: list which skill directories to copy to the project. Include the full path.

**Custom project skills**: create new skills encoding project-specific conventions. Use SKILL.md format with frontmatter. Keep each under 100 lines.

Good: "In this project we use Prisma. To add a model: 1) edit schema.prisma, 2) run migrate, 3) regenerate client."
Bad: "Prisma is an ORM for Node.js."

**MCP Servers**: search via WebSearch if available. Mark as "verified" or "recommended — verify before installing". If nothing good exists — say so.

**CLI Tools**: only what the stack actually needs.

**Project CLAUDE.md recommendations**: suggest key points (build commands, conventions, architecture notes).

## Quality Criteria

- Every tool has a clear purpose tied to the project
- No redundant tools (two tools doing the same thing)
- Prerequisites (API keys, accounts) are listed upfront
- Library skills and custom skills are clearly separated
- Custom skills follow the format of skills in `skills-library/`
