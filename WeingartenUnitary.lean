/-
Copyright (c) 2026 Fred Rajasekaran. All rights reserved.
Released under Apache 2.0 license.

# The explicit unitary Weingarten formula — locked statement

Capstone board "WeingartenUnitary" of the Problem Market group "Weingarten calculus in
Lean", after Collins–Śniady. Index conventions verified two ways: rederived from the
fundamental theorem with the invariant vectors `v_σ(i,i') = δ_{i' = i∘σ}`, and checked
numerically against known Haar moments (e.g. `E|U₁₁|⁴ = 2/(N(N+1))`).
A submission closes the `sorry` below, keeping the statement verbatim. Everything from the
top of this file through the `:= by` is the locked region. See tasks/WeingartenUnitary.md.
-/
import Mathlib

noncomputable section

open MeasureTheory

namespace WeingartenUnitary

/-- Number of cycles of a permutation of `Fin d`, fixed points included. -/
def cycleCount {d : ℕ} (g : Equiv.Perm (Fin d)) : ℕ :=
  (d - g.cycleType.sum) + g.cycleType.card

/-- The Gram matrix of the permutation operators on `(ℂ^N)^{⊗d}`:
`⟨A_σ, A_τ⟩ = N ^ #cycles(σ⁻¹ τ)`. -/
def wgGram (N d : ℕ) : Matrix (Equiv.Perm (Fin d)) (Equiv.Perm (Fin d)) ℂ :=
  fun σ τ => (N : ℂ) ^ cycleCount (σ⁻¹ * τ)

/-- **The unitary Weingarten formula** in the stable range `d ≤ N`: mixed Haar moments
of the matrix entries of a Haar-distributed unitary are computed by the inverse Gram
matrix `(wgGram N d)⁻¹`. -/
theorem weingarten_unitary (N d : ℕ) (hd : d ≤ N)
    [MeasurableSpace (Matrix.unitaryGroup (Fin N) ℂ)]
    [BorelSpace (Matrix.unitaryGroup (Fin N) ℂ)]
    (μ : Measure (Matrix.unitaryGroup (Fin N) ℂ)) [μ.IsHaarMeasure] [IsProbabilityMeasure μ]
    (i j i' j' : Fin d → Fin N) :
    ∫ U, (∏ x, (U : Matrix (Fin N) (Fin N) ℂ) (i x) (j x)) *
         star (∏ x, (U : Matrix (Fin N) (Fin N) ℂ) (i' x) (j' x)) ∂μ
      = ∑ σ : Equiv.Perm (Fin d), ∑ τ : Equiv.Perm (Fin d),
          (if (∀ x, i' x = i (σ x)) ∧ (∀ x, j' x = j (τ x))
           then (wgGram N d)⁻¹ σ τ else 0) := by
  sorry

end WeingartenUnitary
