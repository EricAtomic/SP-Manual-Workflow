---
name: sp-develop
description: manual plan execution workflow for implementing a written plan task-by-task in the current session. use when the user says to execute, implement, continue, work through a plan, or perform inline development. enforces preflight plan review, no implementation on main/master without explicit consent, strict red-green-refactor tdd, fresh verification evidence before completion claims, blocker-only pauses, task tracking, commits, and handoff to sp-review at review points.
---

# SP Develop

Use this skill to execute a written implementation plan inline in the current session. It combines the current `executing-plans`, `test-driven-development`, and `verification-before-completion` behaviours for manual workflows.

Announce that you are using `sp-develop` to implement the plan.

## Non-negotiable rules

- Do not start implementation on `main` or `master` without explicit user consent.
- Load and review the plan before editing files.
- Follow the plan task-by-task and step-by-step.
- Stop only for real blockers, critical plan gaps, unclear instructions, missing dependencies, repeated verification failures, or user-requested checkpoints.
- Do not pause after arbitrary batches just to report progress.
- No production code before a failing test for behaviour changes.
- No completion claim without fresh verification evidence from the current session.
- Ask for clarification instead of guessing when the plan is unsafe or ambiguous.

## Preflight

1. Read the plan file or user-provided plan.
2. Inspect the current branch and workspace state.
3. If on `main` or `master`, ask for explicit consent before editing, or create/switch to a feature branch if the user has already authorised that workflow.
4. Review the plan critically:
   - missing files or dependencies
   - undefined symbols or impossible commands
   - test strategy gaps
   - risky migrations or destructive steps
   - conflicts with the current codebase
5. If critical concerns exist, raise them before starting.
6. If no blocking concerns exist, create a task list and begin.

## Execution loop

For each plan task:

1. Mark the task in progress.
2. Follow each checkbox step exactly.
3. Apply TDD for behaviour changes.
4. Run the exact verification command from the plan.
5. Read the full output and exit code.
6. Fix failures before proceeding, unless the failure reveals a blocker that needs user input.
7. Commit when the plan asks for a commit and verification is clean.
8. Request or perform review at the planned checkpoint.
9. Mark the task complete only after verification evidence supports completion.

Do not silently skip steps. If a planned step is wrong, explain the problem and update the plan or ask the user.

## TDD iron law

```text
no production code without a failing test first
```

For every feature, bug fix, refactor, or behaviour change:

1. Write one minimal test that describes desired behaviour.
2. Run the test and watch it fail.
3. Confirm the failure is for the expected reason, not syntax or setup.
4. Write the simplest production code that can pass.
5. Run the test and watch it pass.
6. Run relevant surrounding tests.
7. Refactor only while tests stay green.
8. Repeat for the next behaviour.

If production code was written first, delete it and restart from a failing test. Do not keep it as reference. Do not adapt it while writing tests.

## Good test standards

Prefer tests that:

- exercise real production code
- verify one behaviour at a time
- have clear behaviour-focused names
- show the intended API or user outcome
- cover edge cases and errors when relevant

Avoid tests that primarily verify mocks, implementation details, or test-only hooks. Use mocks only when unavoidable, and keep them close to external boundaries.

## Verification gate

Before making any claim that work is complete, passing, fixed, clean, ready, or good:

1. Identify the command or check that proves the claim.
2. Run the full command fresh in the current session.
3. Read the output and exit code.
4. Confirm it proves the claim.
5. State the result with evidence.

Examples of required evidence:

- tests pass: test command output with zero failures
- linter clean: lint command output with zero errors
- build succeeds: build command exit 0
- bug fixed: regression test for the original symptom passes
- task complete: plan checklist item verified and relevant commands passed

Never rely on previous runs, agent reports, intuition, partial output, or phrases like should, probably, seems, or looks.

## Handling blockers

Stop and ask for help when:

- a dependency is missing and cannot be installed safely
- the plan references files or symbols that do not exist
- an instruction is ambiguous enough to risk wrong behaviour
- verification fails repeatedly after reasonable fixes
- a test cannot be made to fail for the intended reason
- repo evidence contradicts the plan
- a destructive or risky operation was not explicitly approved

When stopping, report:

- the exact step
- what you tried
- the evidence/output
- the smallest decision needed to continue

## Review checkpoints

Use `sp-review`:

- after each completed task when the plan requires it
- after major feature completion
- before merge or PR
- when stuck and a fresh review would help

If subagents are available, use a fresh `general-purpose` reviewer with the bundled review template from `sp-review`. If not, perform the review inline using `sp-review`.

Fix Critical issues immediately. Fix Important issues before proceeding unless the user explicitly accepts the risk. Track Minor issues for later.

## Completion

After all tasks are complete:

1. Reread the plan and create a requirement checklist.
2. Verify every planned requirement has evidence.
3. Run final tests/lint/build/manual checks as appropriate.
4. Request final review with `sp-review`.
5. Present merge/PR/keep/discard options if working on a branch.
6. Do not claim done until the final verification gate passes.

A valid completion report includes:

- tasks completed
- files changed
- commands run and results
- review findings and fixes
- remaining risks or follow-ups
- branch/PR status when relevant
