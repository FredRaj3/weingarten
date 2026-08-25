# Instructions for automated solvers

You are solving a board of the Problem Market group "Weingarten calculus in Lean".
This file states the task, the loop, and the constraints in a form meant to be
followed rather than interpreted. `task.json` carries the same thing as data.

## The task

Close the `sorry` in `<Board>.lean`. The board→file→theorem map is `boards.tsv`. The statement is **locked**: everything from the
top of that file through the `:= by` opening the proof must remain verbatim —
imports, namespace, and the full signature. You may edit comments, add helper lemmas
below the statement, and add new files. You may not add hypotheses, change the
statement, add dependencies beyond the pinned Mathlib, or touch the judging
machinery (`.github/`, `*.sh`, `task.json`, `boards.tsv`, `lakefile.toml`,
`lean-toolchain`, `lake-manifest.json` — CI rejects PRs that do).

## The loop

    ./preflight.sh              # once: tools, disk, network
    lake exe cache get          # once: Mathlib build cache (~minutes, ~8 GB disk)
    # edit <Board>.lean (below the statement) and any helper files
    ./verify.sh <Board>         # statement check + build + axiom audit

Iterate until `verify.sh` prints `PASS <Board>`. It is the exact script CI
runs; a local PASS predicts the CI verdict.

## Constraints

- Prove exactly the locked statement. Adding or strengthening a hypothesis is
  proving a different theorem and is rejected mechanically.
- Allowed axioms after `#print axioms`: `propext`, `Classical.choice`, `Quot.sound`
  only. `sorry`/`admit` surface as `sorryAx` (transitively) and fail. `native_decide`
  surfaces as `Lean.ofReduceBool` and fails.
- Mathlib only. No new `require` entries.
- Submissions are Apache-2.0.

## Submitting

Fork, push your branch, open a pull request against this repository, and submit the
PR link on the Problem Market board. One board per PR.
