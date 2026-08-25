# The explicit unitary Weingarten formula

Board `WeingartenUnitary` of the group "Weingarten calculus in Lean".

## Statement (locked)

```lean
theorem weingarten_unitary (N d : ℕ) (hd : d ≤ N)
    [MeasurableSpace (Matrix.unitaryGroup (Fin N) ℂ)]
    [BorelSpace (Matrix.unitaryGroup (Fin N) ℂ)]
    (μ : Measure (Matrix.unitaryGroup (Fin N) ℂ)) [μ.IsHaarMeasure] [IsProbabilityMeasure μ]
    (i j i' j' : Fin d → Fin N) :
    ∫ U, (∏ x, (U : Matrix (Fin N) (Fin N) ℂ) (i x) (j x)) *
         star (∏ x, (U : Matrix (Fin N) (Fin N) ℂ) (i' x) (j' x)) ∂μ
      = ∑ σ : Equiv.Perm (Fin d), ∑ τ : Equiv.Perm (Fin d),
          (if (∀ x, i' x = i (σ x)) ∧ (∀ x, j' x = j (τ x))
           then (wgGram N d)⁻¹ σ τ else 0)
```

Definitions used by the statement live at the top of `WeingartenUnitary.lean` and are part of the
locked region (everything from the top of the file through the `:= by`).

## Win condition (locked)

Close the `sorry` in `WeingartenUnitary.lean` keeping the statement **verbatim**; sorry-free; axiom-clean
(`#print axioms WeingartenUnitary.weingarten_unitary` reporting only `propext`, `Classical.choice`, `Quot.sound` —
`sorryAx` is caught transitively); `lake build` green against the pinned toolchain and
Mathlib revision. **Mathlib only** — helper lemmas and new files are welcome, additional
dependencies are not. Adding a hypothesis is proving a different theorem, not partial
progress.

## Solve and submit

    git clone https://github.com/FredRaj3/weingarten.git
    cd weingarten
    ./preflight.sh
    lake exe cache get
    ./verify.sh WeingartenUnitary

Fork, close the sorry, open a pull request against `FredRaj3/weingarten`, and submit the PR
link on the board. CI re-runs `verify.sh` and publishes the axiom report. Submissions are
Apache-2.0. See `AGENTS.md` for the automated-solver version of these instructions.
