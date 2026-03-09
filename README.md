# davai

An AI-powered framework that takes your IT project from idea to a development-ready setup.

Works with **Claude Code** and **Cursor**.

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
```

Open the project folder in your AI tool and start development. The AI developer has everything it needs.

## Quick start

```bash
git clone <repo-url> davai
cd davai
bash framework/setup.sh
```

The setup script asks which AI tool you use and configures davai for it:

```
  davai — from idea to project
  ──────────────────────────────

  Which AI tool will you use with davai?

    1) Claude Code
    2) Cursor

  Your choice (1/2):
```

Then start your tool:
- **Claude Code:** `claude` in the davai directory
- **Cursor:** open the davai folder in Cursor

The CEO agent greets you and guides the entire process.

### Switching tools

Run `bash framework/setup.sh` again to reconfigure. Your drafts and projects are preserved — only the instruction files are regenerated.

## Architecture

davai never writes code. It orchestrates the **planning phase** of your project.

**CEO** (`framework/core/ceo-instructions.md`) — the orchestrator. Always stays in this role. Talks to you, launches subagents, presents drafts, iterates until you're happy.

**Setup** (`framework/setup.sh`) — builds `installed/` from `framework/`, replacing `{{variables}}` (like `{{ai_tool}}`) with actual values, then generates the tool-specific instruction file in the project root. `framework/` is never modified — it's the immutable source of truth.

**Config** (`framework/config.yml`) — defines paths and formats for each AI tool. The installed copy (`installed/config.yml`) stores the active tool choice.

**Playbooks** (`framework/agents/`) — instructions for subagents. Each playbook defines how to think and what to produce:
- `product-designer.md` — MoSCoW prioritization, MVP scoping, spec quality criteria
- `tech-lead.md` — 6-criteria scorecard including AI-friendliness of the stack
- `ai-hr.md` — skill/tool selection from library + custom creation
- `architect.md` — task ordering, dependency mapping, verification criteria

**Templates** (`framework/templates/`) — structure for every artifact:
- `1-product-specification.md` — problem, personas, MoSCoW features, data model, integrations
- `2-tech-stack.md` — components, AI-friendliness, workflow commands, alternatives
- `3-performer-requirements.md` — library skills, custom skills, MCP servers, CLI tools
- `implementation-plan.md` — ordered tasks with files and done-criteria
- `project-instructions.md` — template for the project's instruction file

**Skills library** (`framework/skills-library/`) — pre-built skills that can be copied into projects. **Not included in the repo** — you populate it yourself with skills relevant to your work. See [`framework/skills-library/README.md`](framework/skills-library/README.md) for setup instructions.

**Learnings** (`learnings.md`) — grows with every project. Records what worked, what didn't, which stacks fit which project types. Subagents read it to make better recommendations.

## What you get

After running davai, your project folder contains (paths depend on your AI tool):

```
my-project/
├── <tool-config>/
│   └── skills/                  # Tailored for your stack
│       ├── library-skill/       # Copied from davai skills-library
│       └── custom-skill/        # Created specifically for your project
├── memory-bank/
│   ├── 1-product-specification.md
│   ├── 2-tech-stack.md
│   └── 3-performer-requirements.md
├── implementation-plan.md       # Ordered tasks, ready to execute
├── progress.md
└── <instructions-file>          # CLAUDE.md or .cursorrules
```

## Features

- **Multi-tool support** — works with Claude Code and Cursor. One setup script to switch.
- **No persona switching** — CEO stays CEO. Subagents do the heavy lifting in isolated context.
- **Structured subagent prompts** — extract specific fields, not "read and summarize".
- **Resume** — interrupted? davai detects `drafts/progress.md` and offers to continue.
- **Rollback** — redo any phase or go back. Artifacts are managed automatically.
- **Learning** — each project teaches davai. Past insights inform future recommendations.
- **Language-adaptive** — works in any language. Detects from your first message.

## Project structure

```
davai/
├── README.md
├── learnings.md               # Grows with each project
├── drafts/                    # Temp artifacts (auto-created)
├── projects/                  # Created projects land here
│
├── framework/                 # Immutable source (templates with {{variables}})
│   ├── setup.sh               # Interactive setup — run first
│   ├── config.yml             # Tool profiles template
│   ├── core/
│   │   └── ceo-instructions.md
│   ├── agents/
│   ├── templates/
│   └── skills-library/        # Pre-built skills (populate yourself)
│
└── installed/                 # Generated by setup.sh (gitignored)
    ├── config.yml             # With active tool set
    ├── core/                  # {{ai_tool}} → "Claude Code" / "Cursor"
    ├── agents/
    ├── templates/
    └── skills-library/        # Symlink → framework/skills-library
```

## Requirements

One of:
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI
- [Cursor](https://cursor.com/) IDE

## License

Apache-2.0
