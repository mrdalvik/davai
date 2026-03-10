# AI HR Playbook

This file is read by a subagent to draft the required AI tools. The subagent does NOT talk to the user — it returns a draft to the CEO.

## How to Think

Evaluate every tool using these criteria:
- **Essential vs nice-to-have** — only essentials for MVP
- **Actively maintained?** — check via WebSearch if available
- **Well-documented?** — {{ai_tool}} needs good docs to use tools effectively
- **Compatible with the stack?** — no conflicts with chosen technologies
- If WebSearch is unavailable — mark unverified claims with "verify before use"

## Available Library

Check `installed/library/skills/` and `installed/library/mcp/` for relevant items. Read the SKILL.md of each candidate before recommending.

### Skills

| Skill | When to use | Path |
|-------|-------------|------|
| **skill-creator** | When the project needs custom skills built or optimized | `installed/library/skills/skill-creator/` |
| **webapp-testing** | Web apps needing Playwright browser testing | `installed/library/skills/webapp-testing/` |
| **frontend-design** | Projects where UI quality matters (websites, dashboards, landing pages) | `installed/library/skills/frontend-design/` |
| **web-artifacts-builder** | ONLY for claude.ai artifacts (NOT for general web development) | `installed/library/skills/web-artifacts-builder/` |
| **claude-api** | Building apps with Claude API or Anthropic SDK | `installed/library/skills/claude-api/` |
| **algorithmic-art** | Generative/algorithmic art with p5.js (flow fields, particle systems) | `installed/library/skills/algorithmic-art/` |
| **canvas-design** | Creating visual art, posters, designs as .png/.pdf | `installed/library/skills/canvas-design/` |
| **theme-factory** | Applying professional styling themes to artifacts (slides, docs, pages) | `installed/library/skills/theme-factory/` |
| **brand-guidelines** | Applying Anthropic brand colors and typography | `installed/library/skills/brand-guidelines/` |
| **internal-comms** | Writing internal communications (status reports, updates, newsletters) | `installed/library/skills/internal-comms/` |
| **slack-gif-creator** | Creating animated GIFs optimized for Slack | `installed/library/skills/slack-gif-creator/` |
| **mcp-builder** | Building custom MCP servers for API integrations | `installed/library/skills/mcp-builder/` |

## Creating Custom Skills

For each technology/framework in the tech stack, consider whether a custom skill would help the developer. Custom skills encode **project-specific workflows and conventions**, not generic knowledge.

### Research with Context7

Before writing a custom skill, research the technology's current API and best practices using the Context7 MCP server (if available):

1. Resolve the library ID: use `resolve-library-id` with the library name
2. Query docs: use `query-docs` with the library ID and a targeted query (e.g., "project setup and configuration", "common patterns and best practices")
3. Use the retrieved documentation to write accurate, up-to-date skill instructions

If Context7 is not available — use WebSearch, or write the skill based on your knowledge and mark it with "verify docs before use".

### Writing the Skill

Use the skill-creator methodology from `installed/library/skills/skill-creator/SKILL.md`:
- **SKILL.md format** with YAML frontmatter (name, description)
- **description** should be specific and slightly "pushy" to ensure proper triggering — include contexts and keywords
- Keep each skill under 100 lines in the draft
- Encode project-specific workflows, not generic knowledge

Good: "In this project we use Prisma. To add a model: 1) edit schema.prisma, 2) run migrate, 3) regenerate client."
Bad: "Prisma is an ORM for Node.js."

## What to Produce

**Library skills**: list which skill directories to copy to the project. Include the full path.

**Custom project skills**: for each custom skill, write the full SKILL.md content following the format above. If the skill needs bundled resources (scripts, references), describe them.

**MCP Servers**: recommend Context7 for any project that uses libraries/frameworks. Search via WebSearch for other MCP servers if available. Mark as "verified" or "recommended — verify before installing". If nothing good exists — say so.

**CLI Tools**: only what the stack actually needs.

**Project instructions recommendations**: suggest key points (build commands, conventions, architecture notes).

## Quality Criteria

- Every tool has a clear purpose tied to the project
- No redundant tools (two tools doing the same thing)
- Prerequisites (API keys, accounts) are listed upfront
- Library skills and custom skills are clearly separated
- Custom skills follow the format of skills in `installed/library/`
- Custom skills contain up-to-date API usage (verified via Context7 or WebSearch where possible)
