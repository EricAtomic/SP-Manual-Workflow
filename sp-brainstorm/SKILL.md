---
name: sp-brainstorm
description: Use manually at the start of any feature, product change, refactor, bug-adjacent behaviour change, or engineering idea before planning or coding. Clarify the request, inspect existing project context, ask targeted questions, compare approaches, and write an approved specification to docs/sp/specs/. Even simple changes need at least a short design. Do not generate an implementation plan, modify production code, commit, or invoke the next stage automatically.
---

# SP Brainstorm

Turn a vague request into a reviewed specification. This is stage 1 of a manual, segmented workflow:

`/sp-brainstorm -> /sp-plan -> /sp-develop -> /sp-review -> /sp-develop ...`

## Stage Contract

Input:
- A user idea, problem, feature request, refactor goal, or product change.
- Optional repo context, docs, constraints, examples, screenshots, tickets, or previous decisions.

Output:
- One written spec at `docs/sp/specs/YYYY-MM-DD--<slug>-spec.md`.
- A short final message containing the spec path and the suggested next manual command.

Hard boundaries:
- Do not write implementation plans.
- Do not edit production code.
- Do not start development.
- Do not auto-invoke `/sp-plan`; only suggest it.
- Do not commit unless the user explicitly asks.

## Non-Negotiable Design Gate

Do not skip this stage because the change looks simple. For a tiny change, the design can be only a few paragraphs, but it must still clarify intent, constraints, and acceptance criteria before planning or coding.

## Process

### 1. Inspect Context First

Before asking detailed questions, inspect the current project when available:
- Existing README, docs, architecture notes, package files, tests, and recent conventions.
- Similar features or modules already present.
- Obvious constraints from framework, platform, deployment, APIs, persistence, auth, or UI patterns.
- Prior specs or plans in `docs/sp/` or `docs/superpowers/` that may affect this work.

If context is unavailable, say so and continue with best-effort questions. Make assumptions explicit in the spec.

### 2. Scope Gate

If the request contains multiple independent systems, pause and decompose it.

Examples that need decomposition:
- A platform with auth, billing, chat, analytics, and admin tools.
- A mobile feature plus backend changes plus migration plus analytics.
- A rewrite, new UI surface, and data model change that can ship independently.

Ask the user which sub-project should be specified first. Each sub-project gets its own spec-plan-develop-review loop.

### 3. Ask Questions One at a Time

Ask exactly one question per turn when clarification is needed.

Prefer multiple-choice questions when possible. Focus on:
- User goal and success criteria.
- Required behaviours and non-goals.
- Users, states, edge cases, errors, permissions, and data flow.
- Compatibility, migration, performance, security, accessibility, and observability.
- Acceptance tests or examples.

Stop asking when you have enough to propose a design. Do not over-interview for trivial changes.

### 4. Present Options

Before settling, present 2-3 viable approaches with trade-offs.

For each option include:
- What it changes.
- Why it is attractive.
- Main risk or cost.
- When to choose it.

Lead with your recommendation and explain why.

### 5. Present the Proposed Spec

Present a concise design for user approval. Scale depth to complexity.

Cover when relevant:
- Goal and non-goals.
- User-facing behaviour.
- Architecture and component boundaries.
- Data model or API changes.
- State flow, errors, and edge cases.
- Testing and acceptance criteria.
- Rollout, migration, compatibility, and rollback.
- Security, privacy, and performance considerations.

Design for isolation and clarity:
- Prefer small units with one clear purpose.
- Define interfaces so a reader can understand what a unit does without reading internals.
- Follow existing project patterns unless a targeted improvement is needed for this work.
- Avoid unrelated refactors.

Ask for approval before writing the file.

### 6. Write the Spec

After approval, write the spec to:

`docs/sp/specs/YYYY-MM-DD--<slug>-spec.md`

Use this structure:

```markdown
# <Feature Name> Spec

Status: Approved for planning
Date: YYYY-MM-DD
Owner: <user or unknown>

## Summary

## Goals

## Non-Goals

## Current Context

## Proposed Design

## User / System Behaviour

## Components and Boundaries

## Data, API, or Persistence Changes

## Error Handling and Edge Cases

## Security, Privacy, and Performance

## Testing and Acceptance Criteria

## Rollout / Migration / Backout

## Open Questions
```

Open Questions should be empty or explicitly marked as non-blocking. A spec with blocking open questions is not ready for `/sp-plan`.

### 7. Self-Review the Spec

Before final response, review the written spec for:
- Placeholders such as TBD, TODO, later, etc.
- Contradictions.
- Requirements not covered by acceptance criteria.
- Ambiguous phrasing that could be interpreted two ways.
- Scope too large for one plan.
- Missing edge cases or failure states.
- Architecture/component boundaries that are unclear or too broad.

Fix issues inline. No separate reviewer/subagent loop is required for this manual workflow.

## Final Response Format

End with:

```text
Spec written to: docs/sp/specs/YYYY-MM-DD--<slug>-spec.md
Next suggested command: /sp-plan docs/sp/specs/YYYY-MM-DD--<slug>-spec.md
```

If the user did not approve the spec yet, do not write it; ask for approval or changes.
