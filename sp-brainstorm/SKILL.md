---
name: sp-brainstorm
description: manual brainstorming and design-spec workflow for software, product, feature, component, architecture, behaviour-change, or implementation requests. use before writing code, scaffolding projects, editing production behaviour, or starting an implementation plan. forces context discovery, scope checks, one-question-at-a-time clarification, approach trade-offs, design approval, written spec self-review, user spec-review gate, and handoff only to sp-plan.
---

# SP Brainstorm

Use this skill to turn an idea into an approved design/specification before implementation. Do not write code, scaffold files, change behaviour, or start implementation planning until the user approves the design and the written spec has passed review.

## Hard gate

Every project goes through a design gate. Even a small utility, config change, UI tweak, or refactor needs at least a short design summary and explicit approval. If you are tempted to say it is too simple, write a smaller design instead of skipping the gate.

The only normal handoff after this skill is `sp-plan`.

## Workflow

Create and work through a visible task list for these steps:

1. Explore current context.
2. Check whether the scope is too large for one spec.
3. Offer a visual companion when upcoming decisions would be clearer visually.
4. Ask clarifying questions one at a time.
5. Propose two or three approaches with trade-offs and a recommendation.
6. Present the design in readable sections and get approval.
7. Write the design spec.
8. Run inline spec self-review and fix issues.
9. Ask the user to review the written spec.
10. Hand off to `sp-plan` only after approval.

## Context discovery

Before asking detailed questions, inspect the available context:

- repository structure, relevant files, tests, docs, and configs
- recent commits or existing plans/specs when available
- uploaded files, screenshots, API notes, product requirements, or user-provided examples
- existing conventions and architecture boundaries

For brownfield work, ground questions and design choices in observed files, modules, APIs, and test patterns. Do not ask the user to restate facts you can inspect.

## Scope check and decomposition

If the request contains multiple independent subsystems, stop broad refinement and call out the scope problem. Examples include building a whole platform with auth, billing, analytics, notifications, and storage in one request.

Help decompose the work into sub-projects. Each sub-project should have its own spec, plan, implementation, and review cycle. Brainstorm the first sub-project through the normal workflow.

## Visual companion

When visual material would materially improve the conversation, offer it once in its own message before detailed questioning. Examples: UI layouts, wizard flows, information architecture, diagrams, architecture topology, visual alternatives, or side-by-side mocks.

Use this exact shape, adapted only for available tools:

> Some of this might be easier to explain visually. I can create diagrams, mockups, comparisons, or other visual aids as we go. Want to use visuals for the parts where they help?

The offer must be a standalone message. Do not combine it with clarifying questions or summaries. If the user declines, continue text-only.

For each later question, choose visual or text based on whether seeing the answer would be clearer than reading it. Do not make every UI/product question visual by default.

## Clarifying questions

Ask one question per message. Prefer multiple-choice questions when they reduce effort, but use open-ended questions when nuance matters. Focus on:

- purpose and user value
- constraints and non-goals
- success criteria
- data, API, UI, and integration boundaries
- failure modes and error handling
- testability and rollout constraints

Do not run a long interview after the design is already clear. Stop when enough information exists to propose approaches.

## Approach exploration

Present two or three viable approaches before choosing. For each approach, state:

- what it optimises for
- complexity and implementation risk
- trade-offs and likely failure modes
- when it would be the right choice

Lead with the recommended approach and explain why it best fits the context. Apply YAGNI aggressively.

## Design presentation

Present the design in sections scaled to complexity. Simple sections can be a few sentences; complex sections should be short enough for the user to review comfortably.

Cover the relevant parts:

- goal and non-goals
- architecture and boundaries
- data flow and state ownership
- UI or API contract
- error handling and edge cases
- test strategy
- rollout or migration, when relevant

After each meaningful section, ask whether it looks right before continuing. Revise when the user pushes back.

## Design quality rules

Design units with clear responsibilities and well-defined interfaces. Each unit should be understandable and testable independently.

For each unit, be able to answer:

- what does it do?
- how is it used?
- what does it depend on?
- can its internals change without breaking consumers?

For existing codebases, follow established patterns. Include targeted improvements only when they directly reduce risk or make the requested work cleaner. Do not propose unrelated refactors.

## Written spec

After the user approves the design, save the validated spec when filesystem access is available:

`docs/superpowers/specs/YYYY-MM-DD--design.md`

Use the user's preferred location when they specify one. Commit the spec if the environment has git access and committing is appropriate.

A good spec contains:

- title, date, and status
- goal and non-goals
- approved approach and alternatives considered
- architecture, boundaries, and data flow
- affected files/modules if known
- user-visible behaviour or API contract
- error handling
- validation and testing strategy
- risks, assumptions, and open questions

## Inline spec self-review

After writing the spec, review it yourself and fix issues inline. Do not dispatch a separate reviewer merely for this review.

Check:

1. Placeholder scan: no TBD, TODO, incomplete sections, or vague requirements.
2. Internal consistency: no contradictions between features, architecture, and tests.
3. Scope check: focused enough for one implementation plan.
4. Ambiguity check: requirements cannot be read two materially different ways. If they can, choose one and make it explicit.

## User review gate

After self-review, ask the user to review the spec before planning. Use this structure:

> Spec written and reviewed at `[path]`. Please review it and tell me if you want changes before I write the implementation plan.

Wait for the user's response. If they request changes, update the spec and rerun self-review. Only proceed to `sp-plan` once the user approves.

## Handoff

After approval, invoke or follow `sp-plan` to create the implementation plan. Do not jump to coding, scaffolding, review, deployment, or any other skill.
