---
name: sp-develop
description: Use manually to implement an execution plan or to apply a review report from sp-review. This skill may edit code, tests, docs, and configuration. It follows the plan, uses test-first development for behaviour changes, records development notes, and stops with a suggestion to run sp-review. It does not perform final approval or skip review.
---

# SP Develop

Implement a plan or address a review report. This is the only stage in the core workflow that should normally edit production code.

Manual loop:

`/sp-develop <plan> -> /sp-review <spec> <plan>`

If review requests changes:

`/sp-develop <review-report> -> /sp-review <spec> <plan>`

## Stage Contract

Input, one of:
- A plan file, usually `docs/sp/plans/YYYY-MM-DD--<slug>-plan.md`.
- A review report, usually `docs/sp/reviews/YYYY-MM-DD--<slug>-review-N.md`.
- A user instruction naming which plan tasks or review issues to handle.

Output:
- Code/test/doc changes.
- Optional dev notes at `docs/sp/dev-notes/YYYY-MM-DD--<slug>-dev-notes.md`.
- A short final message with changed files, verification evidence, and the suggested next manual command.

Hard boundaries:
- Do not mark the work final or ready to merge. That is for review and the user's normal release process.
- Do not auto-invoke `/sp-review`; only suggest it.
- Do not work on main/master unless the user explicitly permits it.
- Do not silently skip tests or verification.
- Do not ignore Critical or Important review findings.

## Initial Safety Check

Before editing:
- Check current branch and working tree status.
- If on `main` or `master`, ask before making changes unless the user already authorised it.
- If there are unrelated local changes, avoid touching them and mention them.
- Read the referenced plan or review report completely.

If the input is a review report, also locate the original spec and plan paths from the report. If missing, ask for them or proceed only on the explicitly listed issues.

## Development Modes

### Mode A: Execute a Plan

1. Load the plan.
2. Identify the next unchecked task or the task requested by the user.
3. Execute task steps in order.
4. Update checkboxes only for steps actually completed.
5. Run the specified verification commands.
6. Record notes for anything changed from the plan.

Prefer small batches. If a plan has many tasks, complete a coherent subset and recommend review before continuing.

### Mode B: Apply a Review Report

1. Load review report.
2. Prioritise Critical, then Important, then Minor if requested.
3. For each issue, understand the root cause before editing.
4. Add or update tests when the issue affects behaviour.
5. Make the smallest safe fix.
6. Run targeted verification.
7. Record which review issues were addressed.

Do not dismiss a review issue without evidence. If you believe the reviewer is wrong, explain why and cite code/tests.

## Test-First Rule

For behaviour changes and bug fixes:

1. Write a focused failing test first.
2. Run it and confirm it fails for the expected reason.
3. Implement the minimal production change.
4. Run the test and confirm it passes.
5. Refactor only while tests stay green.

Exceptions require explicit user permission or a clear non-behavioural category, such as docs-only, formatting-only, generated files, or configuration that cannot reasonably be tested.

If you accidentally write production code first, either remove it before writing the test or clearly tell the user and ask whether to continue.

## Stop Conditions

Stop and ask rather than guessing if:
- The plan is contradictory or missing required details.
- A dependency, environment, credential, migration, or fixture is unavailable.
- Verification fails repeatedly.
- The requested change conflicts with the spec.
- Fixing a review issue requires a larger design decision.

## Dev Notes

When useful, create or update:

`docs/sp/dev-notes/YYYY-MM-DD--<slug>-dev-notes.md`

Suggested structure:

```markdown
# <Feature Name> Dev Notes

Plan: docs/sp/plans/...
Latest Review: docs/sp/reviews/... (if applicable)

## Completed

## Verification Run

## Deviations From Plan

## Issues Addressed

## Follow-Up Risks
```

## Final Response Format

Include:
- What you changed.
- Which plan tasks or review issues were completed.
- Verification commands run and their results.
- Anything not completed.
- Suggested review command.

End with one of:

```text
Next suggested command: /sp-review <spec-path> <plan-path>
```

or, when fixing a review:

```text
Next suggested command: /sp-review <spec-path> <plan-path> <previous-review-path>
```
