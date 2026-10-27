# Options and FZF_DEFAULT_OPTS

fzf has many options — its own `--help`
runs to hundreds of lines — and most of
them are for arranging the window, a
subject this guide deliberately treats
lightly. This chapter is the smaller,
durable set: the options that change
*matching and order*, and the two
environment variables that let you state
your choices once instead of at every
prompt. The outcome: you can make fzf
behave the same way every time, on
purpose, and prove the defaults are
really in force.

## The matching options

Each of these was checked against the
lab binary's own `--help`, and the
starred ones were measured in the lab
as well:

| Option | What it changes |
|---|---|
| `--exact` (`-e`) * | Matching becomes substring matching: letters must sit side by side (`anrp` stops matching, transcript t02) |
| `--smart-case` | The default: lower-case query matches any case; add a capital and the query turns case-sensitive |
| `--ignore-case` (`-i`) / `--no-ignore-case` (`+i`) | Force case one way or the other, whatever the query looks like |
| `--scheme=path` / `--scheme=history` | Swap the scoring rules as a set (chapter 2): paths favour the name part; history keeps recency and drops the bonuses |
| `--no-sort` (`+s`) | Keep the list in input order instead of score order — the matches still filter, they just do not rank |
| `--tac` | Reverse the input before anything else: the feeder's last line becomes the first candidate (the history trick, by hand) |
| `--tiebreak=length,begin,…` | What decides between equal scores: line length is the default decider (chapter 4's `2024` result) |

## The window, briefly

Since the window exists and you will
live in it: `--height=40%` runs fzf in
a pane under your prompt instead of
full-screen; `--layout=reverse` puts
the prompt at the top, list growing
down — the arrangement most shell
widgets use; `--border` frames it.
These change nothing about results,
which is precisely why this guide lists
them once and moves on: arrange the
window to your taste, in the variable
below, and forget them.

## FZF_DEFAULT_OPTS: defaults that ride along

Options stated in `FZF_DEFAULT_OPTS`
are read by every fzf run — window and
filter alike — before the options on
the command line, so what you type
still wins over what the variable
says. The lab proved the variable is
not decorative (transcript
`fzf-lab/transcripts/t04-print-query-and-env.txt`):
one query, two fates, nothing changed
but the environment:

```text
$ find . -type f | sort | FZF_DEFAULT_OPTS=--exact fzf --filter=anrp
  [exit 1]
$ find . -type f | sort | fzf --filter=anrp | wc -l
5
```

With `--exact` riding in from the
environment, the fuzzy query `anrp`
matches nothing; without it, five
lines. A defaults variable that can
silently change a script's answers is
worth knowing about in both directions:
set it deliberately in your shell's
startup (a house style such as
`--layout=reverse --height=40%`), and
when a script's fzf behaves oddly on
someone else's machine, check what
*their* variable says — chapter 16
keeps the entry. (A companion variable,
`FZF_DEFAULT_OPTS_FILE`, names a file
to read the defaults from instead;
same effect, tidier startup files.)
Scripts that must be immune can say so
outright by calling fzf with the
variable emptied for that one run.

## FZF_DEFAULT_COMMAND: the standing feeder

Chapter 5's feeder, made permanent.
When fzf starts at a terminal with no
piped input, it needs a list from
somewhere: recent versions walk the
folder tree themselves (the walker's
rules — follow links, include hidden,
skip `.git` and `node_modules` — are
theirs, and tunable). Set
`FZF_DEFAULT_COMMAND` and your command
is run instead, its output becoming
the list:

```text
$ FZF_DEFAULT_COMMAND='find . -type f' fzf --filter=invoice
./documents/invoice-1042.txt
./documents/invoice-1043.txt
```

The lab ran exactly this under a
pseudo-terminal — the variable applies
only when input is a terminal, which
is the same condition that makes fzf
need a list in the first place
(transcript t04 carries the note). The
feeder you choose here is a real
decision: it decides whether hidden
files exist for you, whether big
generated folders swamp the list, how
long the list takes to build on a
large tree. `find` with your exclusions
is the honest default most people land
on; the widgets of chapter 12 use this
same variable (or their own
per-widget commands) when they build
their file lists.

Check: the transcript t04 contrast is
the check. If your `FZF_DEFAULT_OPTS`
experiment does not change the result,
the variable did not reach fzf — an
unexported shell variable is the usual
cause, and `export` is the fix.
