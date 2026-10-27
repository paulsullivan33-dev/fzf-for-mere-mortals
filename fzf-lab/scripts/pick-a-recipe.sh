#!/usr/bin/env bash
# Pick one recipe out of the sample tree with fzf and print it.
#
# The choice is made with --filter so the script can run
# unattended (that is chapter 8's trick). At a real terminal
# you would drop the --filter and pick by eye instead; the
# rest of the script is unchanged.
#
# Usage: pick-a-recipe.sh [pattern]     (default: pancakes)
set -u
cd "$(dirname "$0")/../sample-tree" || exit 1

pattern=${1:-pancakes}
choice=$(find . -name 'recipe-*.txt' | sort | fzf --filter="$pattern" | head -n 1)

if [ -z "$choice" ]; then
  echo "no recipe matched '$pattern'" >&2
  exit 1
fi

echo "Picked: $choice"
echo "-----"
cat "$choice"
