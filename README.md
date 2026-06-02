# SP Manual Workflow Skills

A simplified, manual-stage derivative of selected [Superpowers](https://github.com/obra/superpowers) workflow skills.

Install by copying these directories into a compatible skills directory such as:

- Claude Code: `~/.claude/skills/`
- GitHub Copilot CLI: `~/.copilot/skills/`
- Codex: `~/.agents/skills/` or project `.agents/skills/`

## Skills

- `sp-brainstorm` - clarify a request and write a spec.
- `sp-plan` - turn an approved spec into an execution plan.
- `sp-develop` - execute a plan or fix a review report.
- `sp-review` - review current changes and return PASS / REQUEST_CHANGES / BLOCKED.

## Manual Flow

```text
/sp-brainstorm <idea>
/sp-plan docs/sp/specs/<spec>.md
/sp-develop docs/sp/plans/<plan>.md
/sp-review docs/sp/specs/<spec>.md docs/sp/plans/<plan>.md

# If review requests changes:
/sp-develop docs/sp/reviews/<review>.md
/sp-review docs/sp/specs/<spec>.md docs/sp/plans/<plan>.md docs/sp/reviews/<previous-review>.md
```

## Intentional Differences From Upstream Superpowers

- No automatic skill chaining.
- No visual companion server.
- No automatic commits.
- No required subagent dispatch.
- No final branch finishing skill.
- Output paths use `docs/sp/` instead of `docs/superpowers/`.
