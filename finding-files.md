# Finding Files

The outcome of this chapter: given a
folder tree and a fragment of memory —
a word from the name, a word from the
folder, a year — you can land on the
file, in the window or in a script,
without knowing its whole name or
walking the tree by eye. Files are the
list fzf is most often fed, and the
feeding has a craft of its own.

## The feeder does the walking

`find` prints the candidates; fzf ranks
them. Each option on the `find` side is
a decision about the universe of chapter
2:

```bash
find . -type f | fzf               # every file below here
find . -type f -name '*.mp3' | fzf  # the songs only
find . -type d | fzf               # folders, not files
```

Pre-filtering in the feeder is not
cheating; it is how a list stays honest.
The lab asked a songs-only feeder for
`river` and got the one song that fits
(transcript `fzf-lab/transcripts/t03-finding-files.txt`):

```text
$ find . -type f -name '*.mp3' | fzf --filter=river
./music/quiet-river.mp3
```

## Words can come from anywhere in the line

A file's line is its whole path, and the
query's *and* (chapter 4) can take one
word from the folder and one from the
name:

```text
$ find . -type f | fzf --filter='documents invoice'
./documents/invoice-1042.txt
./documents/invoice-1043.txt
```

Neither word alone is the file; together
they are a description of it. This is
the everyday way files are actually
found with fzf — not by a name, but by
two or three true things about it.

## Matching the name alone

Sometimes the folder words are noise: a
query meant for the name keeps fitting
the path instead. `--nth` limits which
part of each line the matching may look
at. Split the line on `/` and count only
the last field — the name — with `-1`:

```text
$ find . -type f | fzf --delimiter / --nth -1 --filter=documents
  [exit 1]
$ find . -type f | fzf --filter=documents | wc -l
14
$ find . -type f | fzf --delimiter / --nth -1 --filter=bridge
./photos/the-old-bridge.jpg
```

Fourteen lines contain "documents" as a
path; *no* file is named anything like
it, and with the name-only scope fzf
says so. `bridge`, a real name fragment,
still lands. Name-only matching is the
right scope when the tree is deep and
its folder names repeat — and the wrong
one when the folder is the very thing
you remember, so treat it as a lens you
pick up deliberately, not a default.
(The `path` scoring scheme of chapter 2
is the gentler version of the same idea:
the whole line still counts, but a fit
in the name counts for more.)

## The standing feeder

Typing the same `find` becomes a chore,
so don't: at a terminal, fzf's own
default list *is* the files below the
current folder, and `FZF_DEFAULT_COMMAND`
(chapter 11) replaces it with a feeder of
your choosing — hidden files in or out,
one tree or another, your call, made once
in your shell's startup instead of at
every search. Ctrl-T (chapter 12) uses
that same standing list to drop a chosen
file's name into a command you are
halfway through typing — `cat `, Ctrl-T,
a few letters, Enter, and the name is
on the line.

Check: all three `--nth` results above
are transcript t03, run against the
practice tree. If your run of the first
differs, the usual cause is a different
working folder: the lines are paths
*from where you stand*, and the scope
counts fields in those paths.
