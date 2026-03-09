# Library

Pre-built skills and MCP servers that can be copied into projects by the AI HR agent.

## Structure

```
library/
├── skills/               # AI developer skills
│   ├── my-skill/
│   │   ├── SKILL.md      # Required: frontmatter + instructions
│   │   ├── reference.md  # Optional: detailed docs
│   │   └── scripts/      # Optional: helper scripts
│   └── another-skill/
│       └── SKILL.md
└── mcp/                  # MCP server templates
    └── my-mcp-server/
        └── SKILL.md
```

## Setup

The library is **not included** in the repository. You populate it yourself with items relevant to your work.

Good sources:
- Community skills from GitHub
- Create your own using the `skill-creator` workflow

## Skill format

```yaml
---
name: my-skill
description: "What it does and when to use it"
---

Instructions for the AI developer...
```

## How it's used

During Phase 3 (AI Tools & Skills), the AI HR subagent scans `skills/` and `mcp/`, reads each `SKILL.md`, and recommends relevant items for the project. Selected skills are copied into the project's skills directory (path depends on the AI tool configured in `framework/config.yml`).

If the library is empty, AI HR will search online and create custom skills from scratch.
