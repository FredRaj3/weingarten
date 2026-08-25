# Weingarten integrals of the symmetric group, denominators cleared

Board `SymmetricGroupCount` of the group "Weingarten calculus in Lean".

## Statement (locked)

```lean
theorem weingarten_symmetric (N d : ℕ) (i j : Fin d → Fin N) :
    (Finset.univ.filter fun g : Equiv.Perm (Fin N) => ∀ x, g (j x) = i x).card
      = if ∀ x y, i x = i y ↔ j x = j y
        then (N - (Finset.univ.image i).card).factorial
        else 0
```

Definitions used by the statement live at the top of `SymmetricGroupCount.lean` and are part of the
locked region (everything from the top of the file through the `:= by`).

## Win condition (locked)

Close the `sorry` in `SymmetricGroupCount.lean` keeping the statement **verbatim**; sorry-free; axiom-clean
(`#print axioms SymmetricGroupCount.weingarten_symmetric` reporting only `propext`, `Classical.choice`, `Quot.sound` —
`sorryAx` is caught transitively); `lake build` green against the pinned toolchain and
Mathlib revision. **Mathlib only** — helper lemmas and new files are welcome, additional
dependencies are not. Adding a hypothesis is proving a different theorem, not partial
progress.

## Solve and submit

    git clone https://github.com/FredRaj3/weingarten.git
    cd weingarten
    ./preflight.sh
    lake exe cache get
    ./verify.sh SymmetricGroupCount

Fork, close the sorry, open a pull request against `FredRaj3/weingarten`, and submit the PR
link on the board. CI re-runs `verify.sh` and publishes the axiom report. Submissions are
Apache-2.0. See `AGENTS.md` for the automated-solver version of these instructions.
