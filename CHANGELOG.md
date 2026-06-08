# Changelog

## 2026-06-09 update

* Updated `sp-brainstorm` to align with the latest upstream brainstorming workflow, including stricter design gating, prior-context lookup, visual companion guidance, spec self-review, explicit user review gates, and clearer handoff boundaries into planning only.
* Updated `sp-plan` with the latest writing-plans behaviour: scope checks, file-structure pre-review, no-placeholders enforcement, inline self-review, fresh-session assumptions, and explicit execution-mode selection.
* Updated `sp-develop` to reflect the current executing-plans guidance: avoid implementing directly on `main`/`master`, continue through plan steps without fixed batch pauses, stop only for blockers or required decisions, and preserve verification-before-claims discipline.
* Updated `sp-review` to match the upstream self-contained code review template, replacing reliance on the removed named `code-reviewer` agent with `general-purpose` reviewer instructions, severity calibration, file/line-specific findings, and plan-problem detection.
* Synchronized cross-skill workflow assumptions with upstream v5.1.0 changes, including removal of legacy slash-command references, removal of integration-section assumptions, and consolidation of code-review instructions inside the review skill.

## 2026-06-02 update

- Updated `sp-brainstorm` with a stricter design gate for simple changes, prior docs lookup, and clearer isolation/boundary guidance.
- Updated `sp-plan` with a stronger no-placeholders section, fresh-session planning assumption, type/name consistency checks, and review hooks.
- Updated `sp-develop` with critical plan review before editing, review-feedback evaluation discipline, continuous execution only when explicitly requested, and verification-before-claims rules.
- Updated `sp-review` with upstream code-reviewer template concepts: strengths, severity calibration, file/line specificity, why-it-matters, plan-problem detection, and anti-vague-review red flags.