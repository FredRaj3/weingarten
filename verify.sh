#!/usr/bin/env bash
# verify.sh — the whole automated standard for one board, in one script.
#
# CI runs this exact file, and so do you. "Green on my machine" and "green in
# CI" cannot diverge when there is only one implementation of what green means.
#
#   ./verify.sh <Board>     one board (see boards.tsv for names)
#   ./verify.sh             every board — fails on main by design, since every
#                           statement is still open; that failing run is the
#                           control showing the check can tell a proof from a gap.
#
# Exit 0 means the mechanical half of review will pass. It does NOT mean the
# statement says what the board claims it says — see AGENTS.md.

set -uo pipefail
BOARD="${1:-}"

if [ -z "$BOARD" ]; then
  rc=0
  while IFS=$'\t' read -r b _; do echo "#### $b"; ./verify.sh "$b" || rc=1; done < boards.tsv
  exit $rc
fi

THM=$(awk -F'\t' -v b="$BOARD" '$1==b{print $3}' boards.tsv)
[ -n "$THM" ] || { echo "verify: unknown board '$BOARD' (see boards.tsv)" >&2; exit 2; }
fail=0

echo "== statement =="
./check-statement.sh "$BOARD" || fail=1

echo "== build =="
lake exe cache get >/dev/null 2>&1 || echo "  (cache unavailable; building from source will be slow)"
lake build "$BOARD" || { echo "build FAILED"; exit 1; }

echo "== axioms =="
# The axiom report is the real check for sorry/admit/native_decide, not a text
# search: a sorry anywhere beneath the theorem shows up as sorryAx transitively,
# and native_decide shows up as Lean.ofReduceBool.
printf 'import %s\n#print axioms %s\n' "$BOARD" "$THM" > ".axiom_check_$BOARD.lean"
lake env lean ".axiom_check_$BOARD.lean" > "axiom-report-$BOARD.txt" 2>&1
rm -f ".axiom_check_$BOARD.lean"
cat "axiom-report-$BOARD.txt"

if grep -q "sorryAx\|Lean.ofReduceBool" "axiom-report-$BOARD.txt"; then
  echo "FAILED: the proof depends on sorry or native_decide"; fail=1
elif grep -q "depends on axioms: \[propext, Classical.choice, Quot.sound\]" "axiom-report-$BOARD.txt"; then
  echo "axioms OK — exactly the three Mathlib itself rests on"
elif grep -q "does not depend on any axioms" "axiom-report-$BOARD.txt"; then
  echo "axioms OK — none"
else
  echo "FAILED: could not read a clean axiom report. Treat as unverified."; fail=1
fi

[ "$fail" = 0 ] && echo "PASS $BOARD" || echo "FAIL $BOARD"
exit $fail
