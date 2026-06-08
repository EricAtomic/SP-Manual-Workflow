---
name: sp-plan
description: manual implementation planning workflow for approved specs, requirements, architecture notes, or design documents before code changes. use to convert a spec into exact bite-sized engineering tasks with file paths, complete code where relevant, test-first steps, verification commands, commits, scope checks, file-structure mapping, no-placeholder enforcement, inline self-review, and execution handoff to subagent-driven work or sp-develop.
---

# SP Plan

Use this skill after a design/specification or clear requirements exist. The output is a complete implementation plan that a capable engineer or agent can execute without project context.

Announce that you are using `sp-plan` to create the implementation plan. Do not touch production code while planning.

## Inputs

Use the strongest available source of truth:

- approved `sp-brainstorm` spec
- user-provided requirements or ticket
- uploaded PRD/design/API docs
- repository evidence from relevant files, tests, and configs

If requirements are still too vague to plan responsibly, return to `sp-brainstorm` rather than inventing details.

## Save location

Save plans to:

`docs/superpowers/plans/YYYY-MM-DD--implementation-plan.md`

Use the user's preferred location when specified.

## Scope check

Before task decomposition, check whether the spec spans independent subsystems. If it does, suggest separate plans, one per subsystem. Each plan must produce working, testable software on its own.

Do not write a single giant plan that mixes unrelated workstreams unless the user explicitly insists. If they insist, make phase boundaries and risks explicit.

## File structure map

Before defining tasks, map the files to create or modify and the responsibility of each file. This is where decomposition decisions are locked in.

Include:

- exact paths for existing files when known
- proposed paths for new files
- ownership/responsibility of each file
- interfaces between files/modules
- tests associated with each unit
- migration/config/docs files when relevant

Rules:

- Prefer small focused files over large files that do too much.
- Split by responsibility and change locality, not by arbitrary technical layers.
- Follow existing codebase patterns.
- If a file you must modify is already unwieldy, include a focused split when it reduces risk.
- Do not restructure unrelated code.

## Plan header

Every plan starts with this header:

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** implement task-by-task. Prefer subagent-driven development when the platform supports it; otherwise use `sp-develop` for inline execution with checkpoints.

Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** [one sentence]
**Architecture:** [2-3 sentences]
**Tech stack:** [key technologies/libraries]
**Source of truth:** [spec/ticket/docs/repo evidence]

---
```

## Task granularity

Make each task small enough to execute safely and review independently. Within each task, every step should be one action, usually 2-5 minutes:

- write the failing test
- run it and verify it fails for the expected reason
- implement the minimal code to pass
- run tests and verify they pass
- refactor only after green
- run relevant verification
- commit

Do not batch multiple behaviours into one test step. Do not hide work in vague phrases.

## Task template

Use this structure for every task:

````markdown
### Task N: [Component or behaviour]

**Purpose:** [what this task proves or enables]

**Files:**
- Create: `exact/path/to/new_file.ext`
- Modify: `exact/path/to/existing_file.ext:line-range-if-known`
- Test: `exact/path/to/test_file.ext`

- [ ] **Step 1: Write the failing test**
  ```language
  [complete test code or exact test change]
  ```

- [ ] **Step 2: Run test to verify it fails**
  Run: `exact command`
  Expected: FAIL because `[specific missing behaviour]`, not syntax/setup errors.

- [ ] **Step 3: Write minimal implementation**
  ```language
  [complete implementation code or exact patch outline]
  ```

- [ ] **Step 4: Run test to verify it passes**
  Run: `exact command`
  Expected: PASS.

- [ ] **Step 5: Run broader verification**
  Run: `exact command`
  Expected: exit 0 / no failures / no warnings that matter.

- [ ] **Step 6: Commit**
  ```bash
  git add [paths]
  git commit -m "[type]: [specific message]"
  ```
````

For non-code steps such as docs, config, generated artefacts, or manual verification, still provide exact file paths, commands, expected output, and completion evidence.

## No placeholders

These are plan failures. Never leave them in the final plan:

- TBD, TODO, fill in later, implement later
- add appropriate error handling
- handle edge cases
- write tests for the above
- similar to Task N
- update relevant files
- run the tests
- code omitted for brevity
- references to functions, classes, properties, types, or files not introduced earlier
- steps that describe a change without showing how to make or verify it

If a step changes code, include complete code or a precise patch-level instruction. Repeat details even if a later task resembles an earlier one; tasks may be executed out of order.

## TDD requirements in plans

For behaviour changes, every implementation task must follow red-green-refactor:

1. write one minimal failing test for desired behaviour
2. run it and confirm it fails correctly
3. write only enough production code to pass
4. run it and confirm it passes
5. refactor while keeping tests green

Do not include production implementation before the failing test step.

## Verification requirements

Every task needs exact verification commands and expected results. Include the narrow test, relevant wider test suite, lint/type/build checks, and manual verification when applicable.

When the project has established commands, use those. If unknown, infer sensible commands from repo files and mark assumptions explicitly.

## Inline self-review

After writing the full plan, review it yourself and fix issues inline. Do not dispatch a separate plan reviewer just for this check.

Check:

1. Spec coverage: every requirement maps to at least one task.
2. Placeholder scan: none of the no-placeholder failures remain.
3. Type/name consistency: names and signatures introduced in early tasks match later tasks.
4. File structure consistency: every planned file has a responsibility and matching tests or verification.
5. TDD integrity: no production step appears before the failing-test step.
6. Buildability: commands, paths, and imports are plausible in the observed codebase.

If a requirement has no task, add one. If a task has no clear requirement, remove it or justify it.

## Handoff

After saving and self-reviewing the plan, offer execution choice:

```text
Plan complete and saved to `[path]`.

Execution options:
1. Subagent-driven execution, if this platform supports task subagents.
2. Inline execution in this session using `sp-develop`.

Which approach should we use?
```

If the user chooses subagent-driven execution, dispatch fresh implementers per task when available and review between tasks. If the user chooses inline execution or subagents are unavailable, follow `sp-develop`.
