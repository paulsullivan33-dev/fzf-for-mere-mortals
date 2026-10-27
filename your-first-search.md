# Your First Search

This chapter runs one search twice: once
in the window, the way you will do it
every day, and once with no window at
all, the way this guide's lab measured
it — so that what the window does with
your keystrokes is something you have
also seen as plain, checkable output.
The outcome: a list of twenty-seven
files, reduced by a few remembered
letters to the two you wanted.

## The list

The lab works in this guide's practice
tree — build it once:

```bash
fzf-lab/build-sample-tree.sh
cd fzf-lab/sample-tree
```

Twenty-seven files: fourteen documents,
eight songs, five photos, every name
invented for the purpose. The list the
search will rank is the tree's file
names, printed by `find`:

```bash
find . -type f | sort
```

`sort` is there so the lab's transcripts
are the same on every machine; fzf does
not need its input sorted, and in daily
use you will not bother.

## The search, in the window

```bash
find . -type f | fzf
```

(At a terminal with nothing piped in,
plain `fzf` lists the folder's files by
itself — same window, feeder built in.
The pipe is shown because the pipe is the
point: the list is yours.)

The window opens with the whole list and
a prompt, `>`, at the bottom. What you
type goes to the query, and the list is
already answering as you type:

- Type `report`. The list narrows as
  you type — `rep` alone still fits the
  recipes too, since r-e-p walks through
  them in order — and settles on two:
  the annual reports. The matched letters
  are highlighted in each line, and the
  info line counts the survivors against
  the whole — `2/27` — as you go.
- The highlight sits on the best match.
  Move it with the arrow keys or with
  Ctrl-K (up) and Ctrl-J (down).
- Press Enter. The window closes and the
  chosen line is printed in your
  terminal, as ordinary output — try
  `find . -type f | fzf > chosen.txt`
  and the line lands in the file instead,
  which is the whole of chapter 8 in
  embryo.
- Another time, press Esc instead. fzf
  prints nothing and leaves with exit
  code 130 (chapter 2) — *nothing chosen*
  is an answer a script can use, not an
  error.

Honesty, per this guide's habit: the
window cannot be driven in the lab's
sandbox, so the keys above are taught
from the project's documentation. Every
result they produce — which lines a
query keeps, and in what order — is what
the rest of this chapter measures through
the windowless face, and the two are the
same engine.

## The search, with no window

`--filter` takes the query as an
argument, prints the matches, and exits:

```text
$ find . -type f | sort | fzf --filter=report
./documents/annual-report-2023.txt
./documents/annual-report-2024.txt
```

(from transcript t01). Now type less.
Fuzzy matching (chapter 2) only needs
the letters in order:

```text
$ find . -type f | sort | fzf --filter=anrp
./documents/annual-report-2023.txt
./documents/annual-report-2024.txt
./music/song-for-a-winter-morning.mp3
./music/rain-on-the-roof.mp3
./photos/cat-on-the-porch.jpg
```

Read the strays, because they teach the
rule better than the hits do. *Song for
a winter morning* fits a-n-r-p across
"for **a**", "mor**n**ing", and the `p`
of `.mp3`. *Cat on the porch* fits across
"c**a**t", "o**n**", the `r` of "porch" —
and the `p` of `.jpg`, the extension
counting like any other letters. Fuzzy
matching is literal-minded: it keeps
anything your letters can walk through,
in order, and trusts the score to put
the sensible ones first. When a stray
outranks your target, the fix is almost
never a different tool — it is a second
word. The query language's *and* (two
space-separated pieces, both must fit)
is the everyday form:

```text
$ find . -type f | sort | fzf --filter='annual 2024'
./documents/annual-report-2024.txt
```

## Reading the order

One more result from t01 to fix the
score in your mind:

```text
$ find . -type f | sort | fzf --filter=2024
./documents/budget-2024.txt
./documents/annual-report-2024.txt
```

`budget-2024` was third in the sorted
input and first in the output. Output
order is *score order*, never input
order, unless you ask otherwise
(`--no-sort`, chapter 11). Scripts that
take the first line of a `--filter`
result are taking the best match — which
is usually the intent, and worth saying
out loud once, here.

Check: in the practice tree, the three
commands above print exactly what is
shown. Your first search is done: one
list, two faces, and the query already
down to fragments.
