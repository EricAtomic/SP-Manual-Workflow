---
name: sp-review
description: manual and subagent-ready code review workflow for completed tasks, major features, bug fixes, refactors, or pre-merge checks. use after each implementation task, at natural checkpoints, before pull requests or merges, when stuck, or when the user asks for a review. supports git-range review, severity-calibrated findings, self-contained general-purpose reviewer prompts, inline fallback review, and strict handling of critical and important issues.
---

# SP Review

Use this skill to review completed work against requirements and code quality standards before issues cascade.

Core principle: review early, review often, and give the reviewer only the context needed to evaluate the work product.

## When to review

Review is mandatory:

- after each task in subagent-driven execution
- after major feature completion
- before merging to main/master
- before creating a pull request when the change is substantial

Review is optional but valuable:

- when stuck
- before refactoring
- after fixing a complex bug
- when implementation diverged from the plan
- when the risk profile changed

## Choose review mode

### Subagent mode

If the platform supports subagents, dispatch a fresh `general-purpose` reviewer. Do not rely on a removed named `code-reviewer` agent. Use `references/code-reviewer.md` as the prompt template.

### Inline mode

If subagents are unavailable, perform the same review yourself in the current session. Read the diff and relevant files directly. Do not pretend an independent reviewer checked the work.

## Prepare the review

1. Identify the review scope:
   - task description or feature summary
   - plan, spec, ticket, or acceptance criteria
   - git range or changed files
2. Get SHAs when git is available:

```bash
BASE_SHA=$(git rev-parse HEAD~1)   # or origin/main / task start commit
HEAD_SHA=$(git rev-parse HEAD)
```

3. Inspect:

```bash
git diff --stat "$BASE_SHA..$HEAD_SHA"
git diff "$BASE_SHA..$HEAD_SHA"
```

If git is unavailable, use the changed file list and file contents as the review scope.

## What to check

Review for:

- plan and requirement alignment
- missing functionality or unjustified deviations
- clean separation of concerns
- type safety and API compatibility
- error handling and edge cases
- security, privacy, data loss, and injection risks
- migrations, rollback, and backward compatibility
- performance and scalability issues that matter now
- tests that verify real behaviour rather than mocks
- missing integration or regression tests
- documentation or user-facing behaviour updates
- build/lint/test verification evidence

## Severity calibration

Not everything is Critical. Categorise by actual impact.

**Critical:** must fix before proceeding. Examples: data loss, security issue, broken core functionality, crash, destructive migration bug, failing required tests, exposed secrets.

**Important:** should fix before proceeding. Examples: missing requirement, significant test gap, poor error handling, architecture mismatch, compatibility issue, confusing user-visible behaviour.

**Minor:** nice to have. Examples: naming polish, small duplication, documentation improvement, local style issue, non-blocking optimisation.

Acknowledge specific strengths before listing issues. Accurate praise makes the review more useful.

## Output format

Use this format:

```markdown
## Strengths
- [specific strength with file/line when useful]

## Issues

### Critical (must fix)
1. **[title]**
   - File: `path:line`
   - Problem: [what is wrong]
   - Why it matters: [impact]
   - Fix: [specific fix]

### Important (should fix)
1. ...

### Minor (nice to have)
1. ...

## Recommendations
- [process or design improvements]

## Assessment
**Ready to proceed:** [yes | no | with fixes]
**Reasoning:** [1-2 sentence technical assessment]
```

If no issues are found, still explain what you checked and why the change is ready.

## Acting on feedback

- Fix Critical issues immediately.
- Fix Important issues before proceeding unless the user explicitly accepts the risk.
- Track Minor issues for later.
- Push back only with technical evidence from code, tests, or requirements.
- If the reviewer found a flaw in the plan rather than the implementation, update the plan or return to planning.

After fixes, rerun relevant verification and review the fix scope again.

## Red flags

Never:

- skip review because the change is simple
- say looks good without reading the diff
- mark nitpicks as Critical
- ignore Critical issues
- proceed with unresolved Important issues by default
- review only summaries or agent reports
- give vague feedback such as improve error handling without specifics
- claim a subagent reviewed the code when you reviewed inline

## Subagent prompt template

When dispatching a reviewer, use the bundled template at `references/code-reviewer.md` and fill the placeholders:

- `{DESCRIPTION}` - what was implemented
- `{PLAN_OR_REQUIREMENTS}` - plan, requirements, or acceptance criteria
- `{BASE_SHA}` - starting commit
- `{HEAD_SHA}` - ending commit

Keep the reviewer context focused. Do not include hidden reasoning or the entire conversation history unless it is part of the requirements.
