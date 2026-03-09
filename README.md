# Davai

The first AI framework that turns a raw idea into a fully structured, development-ready project — before a single line of code is written.

Works with **Claude Code** and **Cursor**.

You describe an idea. Davai walks you through product specification, tech stack selection, tooling, security, and architecture — then creates a project folder with everything an AI developer needs to start building.

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
   Phase 3: AI Tools & Skills
   Subagent selects skills, MCP servers, tools → you review and confirm
        ↓
   Phase 4: Architecture & Implementation Plan
   Subagent designs architecture → ordered task list → you review and confirm
        ↓
   Phase 5: Security Requirements
   Subagent analyzes threats → security requirements for your stack → you review
        ↓
   Phase 6: Project Created!
```

Open the project folder in your AI tool and start development.

## Quick start

```bash
git clone <repo-url> davai
cd davai
```

Open the project in your AI tool:
- **Claude Code:** run `claude` in the davai directory
- **Cursor:** open the davai folder in Cursor

On first launch, Davai greets you, asks which tool you're using, runs setup, and asks you to restart the session. After that — the CEO agent takes over and guides you through the full pipeline.

### Switching tools

Run `bash framework/setup.sh` to reconfigure. Learnings, drafts, and projects are preserved — only the framework-derived files are regenerated.

## What you get

After running through the pipeline, your project folder contains:

```
my-project/
├── <tool-config>/                     # .claude/ or .cursor/
│   └── skills/                        # Tailored for your stack
├── memory-bank/
│   ├── 1-product-specification.md     # Problem, personas, MVP features
│   ├── 2-tech-stack.md               # Stack, workflow commands, alternatives
│   ├── 3-required-ai-tools.md        # Skills, MCP servers, CLI tools
│   ├── 4-implementation-plan.md      # Ordered tasks, ready to execute
│   ├── 5-security-requirements.md    # Threat model, security checklist
│   └── 6-progress.md                 # Task tracking
└── <instructions-file>                # CLAUDE.md or .cursorrules
```

## Features

- **Multi-tool support** — works with Claude Code and Cursor
- **Security by design** — threat modeling and security requirements are built into the planning phase, before any code is written
- **Phase validation** — readiness checklists, cross-checks between phases
- **Resume & rollback** — continue where you left off or redo any phase
- **Learning** — each project teaches Davai, past insights inform future recommendations

## Requirements

One of:
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI
- [Cursor](https://cursor.com/) IDE

See [ARCHITECTURE.md](ARCHITECTURE.md) for technical details.

## License

Apache-2.0
