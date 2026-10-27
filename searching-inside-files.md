# Searching Inside Files

File *names* are the shallow half of
finding. The deeper half is finding a
*line* — the sentence in one document
out of hundreds that mentions the thing.
This chapter's outcome: you can search
the contents of a whole tree and pick
the exact line you want from the
results, with its file and line number
attached. The machinery is chapter 2's,
one feeder further: `grep` finds the
lines, fzf ranks and returns them.

## The feeder finds lines

`grep -rin` walks a tree and prints
every line that fits a pattern, each
prefixed with where it lives:

```text
$ grep -rin cinnamon .
./documents/recipe-pancakes.txt:3:A pinch of cinnamon in the batter.
./documents/shopping-list.txt:3:Cinnamon, sugar, lemons.
./documents/holiday-plan.txt:4:juice with cinnamon sticks in the evening.
```

(transcript `fzf-lab/transcripts/t07-grep-feeder.txt`).
The flags are the feeder's craft: `-r`
recurse, `-i` ignore case, `-n` line
numbers. Each printed line is a complete
little record — *file, line number,
text* — and that is the shape that makes
the next step useful, because whatever
fzf hands back carries its own address.

## fzf picks the line

Pipe the results through fzf and the
query works on the whole record — file
name parts, the text itself:

```text
$ grep -rin cinnamon . | fzf --filter=shopping
./documents/shopping-list.txt:3:Cinnamon, sugar, lemons.
$ grep -rin cinnamon . | fzf --filter='sticks'
./documents/holiday-plan.txt:4:juice with cinnamon sticks in the evening.
```

In the window the same pipe is a
browsable result set: every cinnamon
line in the tree, narrowable by words
you can see in them. This is the
division of labour worth internalising:
`grep` is exact and tireless and knows
nothing of what you meant; fzf is where
"the one about the shopping" becomes a
selection. Faster content searchers
exist — ripgrep is the usual one — and
they print the same file-line-text shape,
so the fzf half of the pipeline does not
change when the feeder does
(chapter 14).

## Acting on a found line

The returned line splits on its colons
into the three facts. A script can take
them apart with `cut` or shell
parameter work (chapter 8's quoting
rules apply — the text part may contain
colons of its own, so split on the
*first two* only). The classic use is an
editor that opens a file at a line:
most editors accept `file` then `+N`,
as in `editor +4 file`, so the pipeline
below is the shape of a real tool —
shown as a pattern, since the choosing
step is the window's:

```bash
grep -rin PATTERN . | fzf | cut -d: -f1,2
# ./documents/holiday-plan.txt:4  →  editor +4 ./documents/holiday-plan.txt
```

## The trap: what the feeder never sends

The lab's own stumble, kept whole in
transcript t90, belongs in this chapter
because it is this chapter's failure
mode in miniature. The first version of
the feeder above was written *without*
`-i`:

```text
$ grep -rn cinnamon .
./documents/recipe-pancakes.txt:3:A pinch of cinnamon in the batter.
./documents/holiday-plan.txt:4:juice with cinnamon sticks in the evening.
$ grep -rn cinnamon . | fzf --filter=shopping
  [exit 1]
```

Two lines, not three — and fzf's search
for `shopping` then "fails", exit 1, no
match. Nothing was wrong with fzf, and
nothing was wrong with the tree. The
shopping list capitalises *Cinnamon*,
`grep` is case-sensitive by default, and
the line was never printed, so for fzf
it did not exist. fzf's smart case
(chapter 2) governs how a *query* meets
the lines it is *given*; it cannot
recover lines a feeder withheld.

The lesson generalises past case: with
this pipeline you are always, in part,
debugging the feeder. A search that
finds nothing deserves one question
before all others — *what did the list
actually contain?* — and the way to ask
it is to run the feeder alone and read.
Chapter 16 keeps this as its first
entry for a reason.

Check: the three-line `grep -rin`
result, and both `--filter` results
above, are transcript t07 exactly. If
your first run shows two lines, you do
not have an fzf problem; you have
transcript t90.
