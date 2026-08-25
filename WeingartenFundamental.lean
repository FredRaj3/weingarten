/-
Copyright (c) 2026 Fred Rajasekaran. All rights reserved.
Released under Apache 2.0 license.

# The fundamental theorem of Weingarten calculus — locked statement

Board "WeingartenFundamental" of the Problem Market group "Weingarten calculus in Lean",
after Collins–Matsumoto–Novak, "The Weingarten Calculus" (arXiv:2109.14890), Theorem 2.1.
A submission closes the `sorry` below, keeping the statement verbatim. Everything from the
top of this file through the `:= by` is the locked region. See tasks/WeingartenFundamental.md.
-/
import Mathlib

noncomputable section

open MeasureTheory

namespace WeingartenFundamental

/-- Entrywise `d`-th tensor (Kronecker) power of a matrix, with rows and columns
indexed by tuples `Fin d → Fin N`. -/
def tensorPow {N : ℕ} (U : Matrix (Fin N) (Fin N) ℂ) (d : ℕ) :
    Matrix (Fin d → Fin N) (Fin d → Fin N) ℂ :=
  fun i j => ∏ x, U (i x) (j x)

/-- **The fundamental theorem of Weingarten calculus** (Collins–Matsumoto–Novak,
Theorem 2.1): if `a 0, …, a (m-1)` is a family of `G`-invariant tensors that spans the
invariant subspace and has invertible Gram matrix, then every degree-`d` Haar moment of
the matrix elements of `π` is computed by the inverse Gram matrix. -/
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
      = ∑ k, ∑ l, a k i * gram⁻¹ k l * star (a l j) := by
  sorry

end WeingartenFundamental
