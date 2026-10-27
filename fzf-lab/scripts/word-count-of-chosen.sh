#!/usr/bin/env bash
# Act on several fzf choices at once: take every file whose
# name matches a pattern and count the words in each.
#
# --multi --filter stands in for ticking several lines with
# TAB in the interactive window (chapter 10). The loop that
# follows is the part worth learning: one chosen line in,
# one action per line, with the name quoted throughout.
#
# Usage: word-count-of-chosen.sh [pattern]   (default: report)
set -u
cd "$(dirname "$0")/../sample-tree" || exit 1

pattern=${1:-report}
find . -type f -name '*.txt' | sort | fzf --multi --filter="$pattern" |
while IFS= read -r chosen; do
  printf '%s: %s words\n' "$chosen" "$(wc -w < "$chosen")"
done
