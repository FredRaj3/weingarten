# weingarten

Criteria repository for the Problem Market group **"Weingarten calculus in Lean"**, posed by Fred Rajasekaran.

4 locked Lean 4 statements awaiting proofs:

| Board | File | Target |
|---|---|---|
| WeingartenFundamental | `WeingartenFundamental.lean` | `WeingartenFundamental.weingarten_fundamental` |
| SymmetricGroupCount | `SymmetricGroupCount.lean` | `SymmetricGroupCount.weingarten_symmetric` |
| GramInvertibility | `GramInvertibility.lean` | `GramInvertibility.wgGram_isUnit` |
| WeingartenUnitary | `WeingartenUnitary.lean` | `WeingartenUnitary.weingarten_unitary` |

- `tasks/<Board>.md` — each board's statement and win condition.
- `AGENTS.md` — instructions for automated solvers; `task.json` — the same as data.
- `verify.sh <Board>` — the complete automated standard for one board; exactly what CI runs.
  `check-statement.sh` — the locked-statement comparison it starts with.

`main` fails its own CI **on purpose**: it holds the unproved statements, and those failing
runs are the control showing the checker can tell a proof from a gap.

Pinned to `leanprover/lean4:v4.34.0-rc1` and Mathlib `v4.34.0-rc1`. Submissions are Apache-2.0.
