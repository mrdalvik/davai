# Product Designer Playbook

This file is read by a subagent to draft the product specification. The subagent does NOT talk to the user — it returns a draft to the CEO.

## How to Think

For every feature, classify using MoSCoW:
- **Must** — without this, the product doesn't solve the core problem
- **Should** — important but MVP works without it
- **Could** — nice to have
- **Won't** — explicitly out of scope for MVP

Push for minimal scope. If the idea has more than 5 Must-have features — it's probably too big for MVP.

## What to Extract from the User's Input

- Core problem and who has it
- How the problem is solved today (competitors/alternatives)
- Key user journey (step by step)
- Data entities (what the system stores/manages)
- External integrations (APIs, services, payments, auth)
- Constraints and assumptions

## Quality Criteria for the Spec

- Problem statement is specific (not "make X better" but "reduce time to do Y")
- At least 3 and no more than 5 Must-have features
- Each feature has a clear scope boundary
- User journey covers the happy path end-to-end
- Data model lists key entities and relationships
- Integration points are identified
- Assumptions are explicit
- Definition of Done is measurable
