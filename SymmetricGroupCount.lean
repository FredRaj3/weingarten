/-
Copyright (c) 2026 Fred Rajasekaran. All rights reserved.
Released under Apache 2.0 license.

# Weingarten integrals of the symmetric group, denominators cleared — locked statement

Board "SymmetricGroupCount" of the Problem Market group "Weingarten calculus in Lean",
after Collins–Matsumoto–Novak, "The Weingarten Calculus" (arXiv:2109.14890), eq. (4).
A submission closes the `sorry` below, keeping the statement verbatim. Everything from the
top of this file through the `:= by` is the locked region. See tasks/SymmetricGroupCount.md.
-/
import Mathlib

namespace SymmetricGroupCount

/-- The Weingarten integral of the permutation representation of `S(N)`, cleared of
denominators: the number of permutations `g` with `g ∘ j = i` is `(N - |image i|)!`
when `i` and `j` have the same fiber pattern, and `0` otherwise. -/
theorem weingarten_symmetric (N d : ℕ) (i j : Fin d → Fin N) :
    (Finset.univ.filter fun g : Equiv.Perm (Fin N) => ∀ x, g (j x) = i x).card
      = if ∀ x y, i x = i y ↔ j x = j y
        then (N - (Finset.univ.image i).card).factorial
        else 0 := by
  sorry

end SymmetricGroupCount
