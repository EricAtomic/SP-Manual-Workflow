# TDD and verification quick reference

## Red-green-refactor

1. Red: write one failing test for desired behaviour.
2. Verify red: run it and confirm it fails for the expected reason.
3. Green: write the smallest production code that passes.
4. Verify green: run it and confirm it passes.
5. Refactor: clean up while keeping tests green.

## Completion claim gate

Before saying work is complete, fixed, passing, clean, ready, or good:

1. identify the proof command
2. run it fresh
3. read full output and exit code
4. confirm the output proves the claim
5. report the claim with evidence

No fresh evidence means no success claim.
