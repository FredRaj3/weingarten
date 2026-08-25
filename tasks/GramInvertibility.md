# The Weingarten Gram matrix is invertible in the stable range

Board `GramInvertibility` of the group "Weingarten calculus in Lean".

## Statement (locked)

```lean
theorem wgGram_isUnit (N d : ℕ) (hd : d ≤ N) : IsUnit (wgGram N d).det
```

Definitions used by the statement live at the top of `GramInvertibility.lean` and are part of the
locked region (everything from the top of the file through the `:= by`).

## Win condition (locked)

Close the `sorry` in `GramInvertibility.lean` keeping the statement **verbatim**; sorry-free; axiom-clean
(`#print axioms GramInvertibility.wgGram_isUnit` reporting only `propext`, `Classical.choice`, `Quot.sound` —
`sorryAx` is caught transitively); `lake build` green against the pinned toolchain and
Mathlib revision. **Mathlib only** — helper lemmas and new files are welcome, additional
dependencies are not. Adding a hypothesis is proving a different theorem, not partial
progress.

## Solve and submit

    git clone https://github.com/FredRaj3/weingarten.git
    cd weingarten
    ./preflight.sh
    lake exe cache get
    ./verify.sh GramInvertibility

Fork, close the sorry, open a pull request against `FredRaj3/weingarten`, and submit the PR
link on the board. CI re-runs `verify.sh` and publishes the axiom report. Submissions are
Apache-2.0. See `AGENTS.md` for the automated-solver version of these instructions.
