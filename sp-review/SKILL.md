---
name: sp-review
description: Use manually after sp-develop to review current code changes against a spec and plan, or to re-review fixes from a previous review. Inspect the diff and relevant files, verify evidence where possible, produce a review report at docs/sp/reviews/, and return PASS, REQUEST_CHANGES, or BLOCKED. Calibrate severity, include strengths, be specific with file/line references, and do not modify code.
---

# SP Review

Review implementation work against the approved spec and execution plan. This is the quality gate in the manual loop.

Manual loop:

`/sp-develop -> /sp-review -> /sp-develop -> /sp-review`

## Stage Contract

Input:
- Spec path, usually `docs/sp/specs/YYYY-MM-DD--<slug>-spec.md`.
- Plan path, usually `docs/sp/plans/YYYY-MM-DD--<slug>-plan.md`.
- Optional prior review report path.
- Optional dev notes path.
- Optional git base/head range.

Output:
- A review report at `docs/sp/reviews/YYYY-MM-DD--<slug>-review-N.md`.
- Status: `PASS`, `REQUEST_CHANGES`, or `BLOCKED`.
- If changes are requested, a concise list that can be passed directly to `/sp-develop`.

Hard boundaries:
- Do not edit code.
- Do not fix issues during review.
- Do not approve without evidence.
- Do not rely only on the developer's summary; inspect the actual diff and relevant files.
- Do not auto-invoke `/sp-develop`; only suggest it.
- Do not mark nitpicks as Critical.

## Review Inputs

Read:
- The spec.
- The plan.
- Current git diff, staged diff, or requested commit range.
- Dev notes if present.
- Prior review report if this is a re-review.
- Relevant tests and implementation files.

If git metadata is unavailable, review the available changed files and state the limitation.

## Review Procedure

### 1. Establish Scope

Identify:
- What the spec required.
- Which plan tasks should be complete.
- What files changed.
- What prior review issues, if any, should have been addressed.
- Whether any plan issue, rather than implementation issue, is blocking progress.

### 2. Inspect Against Spec

Check for:
- Missing required behaviour.
- Behaviour not requested by the spec.
- Incorrect edge cases, error handling, loading states, permissions, or data flow.
- Security, privacy, performance, accessibility, compatibility, or migration risks.

### 3. Inspect Against Plan

Check for:
- Unchecked or skipped tasks.
- Deviations from plan that are not documented.
- Incomplete tests.
- Files modified outside expected scope.
- Commands or verification steps not run.

### 4. Inspect Code Quality

Check for:
- Fragile or over-complex code.
- Duplicated logic.
- Hidden coupling.
- Naming or boundary problems.
- Inconsistent project patterns.
- Poor test quality, excessive mocks, or tests that assert implementation details instead of behaviour.
- Missing documentation where users or future maintainers need it.

### 5. Verify Evidence

Run appropriate tests if possible, especially targeted tests named in the plan. If running commands is unsafe or unavailable, say so clearly and mark verification as limited.

Do not claim tests pass unless you actually ran them in this review or the output is directly available in the current context.

## Severity Calibration

Use actual severity, not dramatic language.

- Critical: unsafe, data loss, security/privacy issue, broken core behaviour, or cannot merge.
- Important: required behaviour missing, meaningful bug, inadequate test, serious maintainability issue, or production-readiness gap.
- Minor: cleanup, naming, small refactor, documentation polish, or non-blocking improvement.

Status rules:

- `PASS`: No Critical or Important issues remain. Minor issues may be listed as optional.
- `REQUEST_CHANGES`: One or more Critical or Important issues must be fixed by `/sp-develop`.
- `BLOCKED`: Review cannot be completed because required context, build, tests, credentials, or files are missing.

If you find significant deviations from the plan, flag them specifically so the developer can confirm whether they were intentional. If the plan itself is wrong or incomplete, say so rather than blaming implementation.

## Review Report Format

Save to:

`docs/sp/reviews/YYYY-MM-DD--<slug>-review-N.md`

Use this structure:

```markdown
# <Feature Name> Review N

Status: PASS | REQUEST_CHANGES | BLOCKED
Date: YYYY-MM-DD
Spec: docs/sp/specs/...
Plan: docs/sp/plans/...
Previous Review: docs/sp/reviews/... (if any)

## Summary

## Strengths

## Scope Reviewed

## Verification Evidence

## Findings

### Critical

### Important

### Minor

## Required Changes for /sp-develop

1. [severity] <specific issue>
   - Location: `path/to/file.ext:line` or area
   - Problem:
   - Why it matters:
   - Required fix:
   - Suggested verification:

## Re-Review Checklist

- [ ] Critical issues addressed
- [ ] Important issues addressed
- [ ] Tests updated and passing
- [ ] No new out-of-scope changes
```

If status is PASS, the Required Changes section should say `None`.

## Red Flags

Never:
- Say "looks good" without checking.
- Give feedback on code you did not read.
- Be vague, such as "improve error handling" without saying where, why, and how to verify.
- Approve with open Critical or Important findings.
- Fail the review for style-only preferences.

## Final Response Format

End with:

For `PASS`:

```text
Review status: PASS
Review written to: docs/sp/reviews/YYYY-MM-DD--<slug>-review-N.md
```

For `REQUEST_CHANGES`:

```text
Review status: REQUEST_CHANGES
Review written to: docs/sp/reviews/YYYY-MM-DD--<slug>-review-N.md
Next suggested command: /sp-develop docs/sp/reviews/YYYY-MM-DD--<slug>-review-N.md
```

For `BLOCKED`:

```text
Review status: BLOCKED
Review written to: docs/sp/reviews/YYYY-MM-DD--<slug>-review-N.md
Blocking issue: <one sentence>
```
