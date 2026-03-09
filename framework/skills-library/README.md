# Skills Library

This directory contains pre-built Claude Code skills that can be copied into projects by the AI HR agent.

## Setup

The skills library is **not included** in the repository. You need to populate it yourself.

### Recommended skills

Find and add skills relevant to your work. Good sources:
- [Claude Code Skills](https://claude.ai/plugins) — official skill plugins
- Community skills from GitHub
- Create your own using the `skill-creator` workflow

### Expected structure

Each skill is a directory with at least a `SKILL.md`:

```
skills-library/
├── my-skill/
│   ├── SKILL.md          # Required: frontmatter + instructions
│   ├── reference.md      # Optional: detailed docs
│   └── scripts/          # Optional: helper scripts
└── another-skill/
    └── SKILL.md
```

### Skill format

```yaml
---
name: my-skill
description: "What it does and when to use it"
---

Instructions for the AI developer...
```

### How it's used

During Phase 3 (Tools & Skills), the AI HR subagent scans this directory, reads each `SKILL.md`, and recommends relevant skills for the project. Selected skills are copied into `<project>/.claude/skills/`.

If this directory is empty, AI HR will search for skills online and create custom ones from scratch.
