# The fundamental theorem of Weingarten calculus

Board `WeingartenFundamental` of the group "Weingarten calculus in Lean".

## Statement (locked)

```lean
theorem weingarten_fundamental {G : Type*} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [T2Space G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure] [IsProbabilityMeasure μ]
    {N d m : ℕ} (π : G →* Matrix.unitaryGroup (Fin N) ℂ)
    (hπ : Continuous fun g => (π g : Matrix (Fin N) (Fin N) ℂ))
    (a : Fin m → (Fin d → Fin N) → ℂ)
    (ha_inv : ∀ k g, (tensorPow ((π g : Matrix (Fin N) (Fin N) ℂ)) d).mulVec (a k) = a k)
    (ha_span : ∀ t : (Fin d → Fin N) → ℂ,
      (∀ g, (tensorPow ((π g : Matrix (Fin N) (Fin N) ℂ)) d).mulVec t = t) →
        t ∈ Submodule.span ℂ (Set.range a))
    (gram : Matrix (Fin m) (Fin m) ℂ)
    (hgram : ∀ k l, gram k l = ∑ v : Fin d → Fin N, star (a k v) * a l v)
    (hunit : IsUnit gram.det)
    (i j : Fin d → Fin N) :
    ∫ g, ∏ x, (π g : Matrix (Fin N) (Fin N) ℂ) (i x) (j x) ∂μ
      = ∑ k, ∑ l, a k i * gram⁻¹ k l * star (a l j)
```

Definitions used by the statement live at the top of `WeingartenFundamental.lean` and are part of the
locked region (everything from the top of the file through the `:= by`).

## Win condition (locked)

Close the `sorry` in `WeingartenFundamental.lean` keeping the statement **verbatim**; sorry-free; axiom-clean
(`#print axioms WeingartenFundamental.weingarten_fundamental` reporting only `propext`, `Classical.choice`, `Quot.sound` —
`sorryAx` is caught transitively); `lake build` green against the pinned toolchain and
Mathlib revision. **Mathlib only** — helper lemmas and new files are welcome, additional
dependencies are not. Adding a hypothesis is proving a different theorem, not partial
progress.

## Solve and submit

    git clone https://github.com/FredRaj3/weingarten.git
    cd weingarten
    ./preflight.sh
    lake exe cache get
    ./verify.sh WeingartenFundamental

Fork, close the sorry, open a pull request against `FredRaj3/weingarten`, and submit the PR
link on the board. CI re-runs `verify.sh` and publishes the axiom report. Submissions are
Apache-2.0. See `AGENTS.md` for the automated-solver version of these instructions.
