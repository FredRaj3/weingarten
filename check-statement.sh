#!/usr/bin/env bash
# check-statement.sh — is this a proof of the theorem we actually posted?
#
# A green build and a clean axiom report only establish that the submitter
# proved *something* honestly. They say nothing about whether it is *our*
# theorem: adding a hypothesis that makes the statement trivially true passes
# every other check we run. This is the check that catches that.
#
# Compares the locked region of a statement file — everything from the top of
# the file down to and including the `:= by` that opens the proof — against the
# criteria commit pinned for that board in task.json. Comments and blank lines
# are ignored; a submitter may annotate freely, but the code may not move.
#
#   Usage:  ./check-statement.sh <Board> [git-ref]     (default ref: working tree)
#           ./check-statement.sh                       every board in boards.tsv

set -uo pipefail
BOARD="${1:-}"; REF="${2:-}"

# Single-board callers (CI helpers, reviewers) pass a git ref as the only
# argument. If the first argument is not a board name, treat it as the ref and
# check every board at it.
if [ -n "$BOARD" ] && ! awk -F'\t' -v b="$BOARD" '$1==b{f=1} END{exit !f}' boards.tsv; then
  REF="$BOARD"; BOARD=""
fi

if [ -z "$BOARD" ]; then
  rc=0
  while IFS=$'\t' read -r b _; do ./check-statement.sh "$b" "$REF" || rc=1; done < boards.tsv
  exit $rc
fi

SPEC=$(awk -F'\t' -v b="$BOARD" '$1==b{print $2}' boards.tsv)
[ -n "$SPEC" ] || { echo "check-statement: unknown board '$BOARD' (see boards.tsv)" >&2; exit 2; }
CRITERIA=$(python3 -c '
import json,sys
for t in json.load(open("task.json"))["tasks"]:
    if t["board"]==sys.argv[1]: print(t["criteriaCommit"])' "$BOARD")
case "$CRITERIA" in *[!0-9a-f]*|"") echo "check-statement: no criteria commit pinned for $BOARD yet" >&2; exit 2;; esac

spec_of() {
python3 -c '
import sys, re
src = sys.stdin.read()
src = re.sub(r"/-.*?-/", "", src, flags=re.S)   # block comments
src = re.sub(r"--[^\n]*", "", src)              # line comments
out = []
for line in src.split("\n"):
    line = line.rstrip()
    if not line.strip():
        continue
    out.append(line)
    if line.endswith(":= by"):
        break
print("\n".join(out))
'
}

tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT

git cat-file -e "$CRITERIA^{commit}" 2>/dev/null || git fetch -q --depth=1 origin "$CRITERIA" 2>/dev/null

if ! git show "$CRITERIA:$SPEC" 2>/dev/null | spec_of > "$tmp/locked"; then
  echo "check-statement: could not read $SPEC at criteria commit $CRITERIA" >&2
  echo "  Usual cause: a shallow clone or a tarball. Re-clone the repository in full." >&2
  exit 2
fi
[ -s "$tmp/locked" ] || { echo "check-statement: locked statement came back empty" >&2; exit 2; }

if [ -n "$REF" ]; then git show "$REF:$SPEC" | spec_of > "$tmp/actual"
else spec_of < "$SPEC" > "$tmp/actual"; fi

if diff -q "$tmp/locked" "$tmp/actual" >/dev/null 2>&1; then
  echo "check-statement: OK — $SPEC identical to criteria commit ${CRITERIA:0:7}"
  exit 0
fi
echo "check-statement: FAILED — $SPEC is not the statement that was posted." >&2
echo "  (< locked at ${CRITERIA:0:7}   > as submitted)" >&2
diff "$tmp/locked" "$tmp/actual" | sed 's/^/  /' >&2
exit 1
