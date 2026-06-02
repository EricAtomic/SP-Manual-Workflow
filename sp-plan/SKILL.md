---
name: sp-plan
description: Use manually after a spec exists and before editing code. Read an approved spec, inspect the repository, and create a detailed execution plan at docs/sp/plans/. The plan must be concrete enough for a separate development session to execute with limited context: exact files, test-first steps, commands, expected outcomes, and review hooks. Do not modify production code, run implementation, commit, or invoke the next stage automatically.
---

# SP Plan

Convert an approved specification into a concrete execution plan. This is stage 2 of a manual, segmented workflow:

`/sp-brainstorm -> /sp-plan -> /sp-develop -> /sp-review -> /sp-develop ...`

## Stage Contract

Input:
- A spec file path, usually `docs/sp/specs/YYYY-MM-DD--<slug>-spec.md`.
- Optional user constraints such as target milestone, preferred implementation order, allowed scope, or test command.

Output:
- One plan at `docs/sp/plans/YYYY-MM-DD--<slug>-plan.md`.
- A short final message containing the plan path and the suggested next manual command.

Hard boundaries:
- Do not edit production code.
- Do not implement the plan.
- Do not auto-invoke `/sp-develop`; only suggest it.
- Do not commit unless the user explicitly asks.

## Planning Assumption

Write for a capable developer or agent who has limited project context and may execute the plan in a fresh session. The plan must carry enough context to prevent guessing.

## Process

### 1. Load and Check the Spec

Read the spec completely. Confirm it is ready for planning:
- It has a goal, non-goals, proposed design, and acceptance criteria.
- Blocking open questions are resolved.
- Scope is small enough for one plan.
- The feature can produce working, testable software on its own.

If the spec is too broad, propose a split and stop. Do not produce a vague mega-plan.

### 2. Inspect the Repo

Before writing tasks, inspect the codebase enough to make concrete choices:
- Existing structure and naming conventions.
- Similar tests and test helpers.
- Build and test commands.
- Relevant APIs, models, UI components, routes, state containers, migrations, or config.

If you cannot inspect the repo, state the limitation and write assumptions explicitly in the plan.

### 3. Map File Responsibilities

Before task decomposition, list the expected files:
- Files to create.
- Files to modify.
- Tests to add or update.
- Docs/config/migration files if relevant.

Prefer small, focused files with clear responsibilities. Split by responsibility and change affinity, not by abstract technical layer. Avoid unrelated refactors. If a touched file is already too large or tangled, include only a targeted cleanup that supports this feature.

### 4. Write Bite-Sized Tasks

Each task should produce a coherent, reviewable increment. Each step should be one concrete action, generally 2-5 minutes of work.

For each task include:
- Objective.
- Exact files.
- Preconditions.
- Steps using checkbox syntax.
- Test-first instruction where behaviour changes.
- Exact commands and expected outcomes.
- Commit suggestion, but do not require commit unless the user wants commits.

Good steps are concrete:
- Write a failing test for a named behaviour.
- Run a named test command and expect a specific failure.
- Implement the smallest production change.
- Run targeted tests and expect pass.
- Run a broader verification command if needed.

Bad steps are vague:
- Add error handling.
- Write tests.
- Implement the feature.
- Similar to previous task.
- Clean up code.

### 5. No Placeholders

These are plan failures and must be fixed before saving:
- `TBD`, `TODO`, `later`, `fill in details`, or `as needed`.
- "Add appropriate error handling" without exact conditions and expected behaviour.
- "Write tests" without naming test files, behaviours, and commands.
- "Similar to Task N" instead of repeating necessary detail.
- Referencing types, functions, flags, routes, or schema fields not defined in the plan or already present in the repo.
- Code-changing steps that do not show what shape the code should take when the details matter.

### 6. Include Review Hooks

The plan must make review easy. Include:
- How to verify each task.
- What visible behaviour should change.
- What files or areas reviewers should inspect.
- Known risks and expected edge cases.
- Which deviations are acceptable and which require user approval.

### 7. Save the Plan

Save to:

`docs/sp/plans/YYYY-MM-DD--<slug>-plan.md`

Use this structure:

```markdown
# <Feature Name> Execution Plan

Status: Ready for development
Date: YYYY-MM-DD
Spec: docs/sp/specs/YYYY-MM-DD--<slug>-spec.md

## Goal

## Architecture Summary

## Assumptions

## File Map

## Verification Strategy

## Tasks

### Task 1: <name>

**Objective:**

**Files:**
- Create:
- Modify:
- Test:

**Steps:**
- [ ] Step 1: Write the failing test for ...
- [ ] Step 2: Run `...` and confirm it fails because ...
- [ ] Step 3: Implement ...
- [ ] Step 4: Run `...` and confirm it passes
- [ ] Step 5: Update docs or notes if needed

**Review focus:**

## Risks and Rollback

## Done Criteria
```

### 8. Self-Review

Before final response, check:
- Every spec requirement maps to at least one task.
- Every task has exact file paths or explicit discovery instructions.
- Every behavioural change has a test-first step unless explicitly exempted.
- No placeholders or vague plan failures remain.
- Commands are concrete, scoped, and include expected outcomes.
- Types, names, routes, config keys, and method signatures are consistent across tasks.
- The plan can be executed in a fresh session with limited context.

Fix issues inline. No separate reviewer/subagent loop is required for this manual workflow.

## Final Response Format

End with:

```text
Plan written to: docs/sp/plans/YYYY-MM-DD--<slug>-plan.md
Next suggested command: /sp-develop docs/sp/plans/YYYY-MM-DD--<slug>-plan.md
```
