# davai

An AI-powered framework for Claude Code that takes your IT project from idea to a development-ready setup.

You describe an idea. davai walks you through product specification, tech stack selection, tooling, and architecture — then creates a project folder with everything an AI developer needs to start building.

## How it works

```
You: "I want to build a Telegram bot that tracks expenses"
        ↓
   Phase 1: Product Specification
   CEO asks questions → subagent drafts spec → you review and confirm
        ↓
   Phase 2: Tech Stack
   Subagent analyzes spec → drafts stack → you review and confirm
        ↓
   Phase 3: Tools & Skills
   Subagent selects skills, MCP servers, tools → you review and confirm
        ↓
   Phase 4: Architecture & Implementation Plan
   Subagent designs architecture → ordered task list → you review and confirm
        ↓
   Phase 5: Project Created!
   → my-bot/.claude/skills/    (AI developer skills)
   → my-bot/memory-bank/       (spec, stack, requirements)
   → my-bot/implementation-plan.md
   → my-bot/CLAUDE.md          (project instructions)
```

Open Claude Code in the project folder and start development. The AI developer has everything it needs.

## Quick start

```bash
cd davai
claude
```

That's it. The CEO agent greets you and guides the entire process.

## Architecture

davai never writes code. It orchestrates the **planning phase** of your project.

**CEO** (`CLAUDE.md`) — the orchestrator. Always stays in this role. Talks to you, launches subagents, presents drafts, iterates until you're happy.

**Playbooks** (`agents/`) — instructions for subagents. Each playbook defines how to think and what to produce:
- `product-designer.md` — MoSCoW prioritization, MVP scoping, spec quality criteria
- `tech-lead.md` — 6-criteria scorecard including AI-friendliness of the stack
- `ai-hr.md` — skill/tool selection from library + custom creation
- `architect.md` — task ordering, dependency mapping, verification criteria

**Templates** (`templates/`) — structure for every artifact:
- `1-product-specification.md` — problem, personas, MoSCoW features, data model, integrations
- `2-tech-stack.md` — components, AI-friendliness, workflow commands, alternatives
- `3-performer-requirements.md` — library skills, custom skills, MCP servers, CLI tools
- `implementation-plan.md` — ordered tasks with files and done-criteria
- `project-claude.md` — template for the project's CLAUDE.md

**Skills library** (`skills-library/`) — pre-built skills that can be copied into projects. **Not included in the repo** — you populate it yourself with skills relevant to your work. See [`skills-library/README.md`](skills-library/README.md) for setup instructions.

**Learnings** (`learnings.md`) — grows with every project. Records what worked, what didn't, which stacks fit which project types. Subagents read it to make better recommendations.

## What you get

After running davai, your project folder contains:

```
my-project/
├── .claude/
│   └── skills/                  # Tailored for your stack
│       ├── library-skill/       # Copied from davai skills-library
│       └── custom-skill/        # Created specifically for your project
├── memory-bank/
│   ├── 1-product-specification.md
│   ├── 2-tech-stack.md
│   └── 3-performer-requirements.md
├── implementation-plan.md       # Ordered tasks, ready to execute
├── progress.md
└── CLAUDE.md                    # Project instructions for AI developer
```

Open Claude Code in this folder — it reads `CLAUDE.md`, has access to skills and the full context in `memory-bank/`. Start building.

## Features

- **No persona switching** — CEO stays CEO. Subagents do the heavy lifting in isolated context.
- **Structured subagent prompts** — extract specific fields, not "read and summarize".
- **Resume** — interrupted? davai detects `drafts/progress.md` and offers to continue.
- **Rollback** — redo any phase or go back. Artifacts are managed automatically.
- **Learning** — each project teaches davai. Past insights inform future recommendations.
- **Language-adaptive** — works in any language. Detects from your first message.

## Project structure

```
davai/
├── CLAUDE.md              # CEO orchestrator
├── README.md
├── learnings.md           # Grows with each project
├── .gitignore
├── agents/                # Subagent playbooks
│   ├── product-designer.md
│   ├── tech-lead.md
│   ├── ai-hr.md
│   └── architect.md
├── templates/             # Artifact templates
│   ├── 1-product-specification.md
│   ├── 2-tech-stack.md
│   ├── 3-performer-requirements.md
│   ├── implementation-plan.md
│   └── project-claude.md
├── skills-library/        # Pre-built skills (populate yourself)
└── projects/              # Created projects land here
```

## Requirements

- [Claude Code](https://claude.ai/claude-code) CLI

## License

Apache-2.0
