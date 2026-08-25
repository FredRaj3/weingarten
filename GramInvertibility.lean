/-
Copyright (c) 2026 Fred Rajasekaran. All rights reserved.
Released under Apache 2.0 license.

# The Weingarten Gram matrix is invertible in the stable range — locked statement

Board "GramInvertibility" of the Problem Market group "Weingarten calculus in Lean".
A submission closes the `sorry` below, keeping the statement verbatim. Everything from the
top of this file through the `:= by` is the locked region. See tasks/GramInvertibility.md.
-/
import Mathlib

noncomputable section

namespace GramInvertibility

/-- Number of cycles of a permutation of `Fin d`, fixed points included. -/
def cycleCount {d : ℕ} (g : Equiv.Perm (Fin d)) : ℕ :=
  (d - g.cycleType.sum) + g.cycleType.card

/-- The Gram matrix of the permutation operators on `(ℂ^N)^{⊗d}`:
`⟨A_σ, A_τ⟩ = N ^ #cycles(σ⁻¹ τ)`. -/
def wgGram (N d : ℕ) : Matrix (Equiv.Perm (Fin d)) (Equiv.Perm (Fin d)) ℂ :=
  fun σ τ => (N : ℂ) ^ cycleCount (σ⁻¹ * τ)

/-- In the stable range `d ≤ N` the Gram matrix of the permutation operators is
invertible — equivalently, the permutation operators are linearly independent. -/
theorem wgGram_isUnit (N d : ℕ) (hd : d ≤ N) : IsUnit (wgGram N d).det := by
  sorry

end GramInvertibility
