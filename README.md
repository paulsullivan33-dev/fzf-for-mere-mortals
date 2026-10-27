# fzf for Mere Mortals

You know the file is in there somewhere.
You remember *report*, and maybe *2024*,
but not which folder, and not the whole
name. **fzf** is a program for exactly
that moment. You hand it a list — of
files, of commands you ran last month,
of lines inside documents — and start
typing the fragments you do remember. The
list shrinks as you type, the lines that
still fit float to the top, and one press
of Enter hands your choice back to the
terminal, ready to use. The trick that
makes it feel like mind-reading is **fuzzy
matching**: your letters do not need to
sit side by side in the answer, they only
need to appear in order — `anrp` finds
`annual-report` without your ever typing
the whole word.

This guide explains how that works, how
to search your first list, how to find
files by fragments, dig a command out of
your history with Ctrl-R, search *inside*
files with a grep-fed list, and put fzf
to work inside your own scripts, where
the same matching runs with no window at
all and its **exit codes** tell your
script whether anything was found. The
limits are stated plainly, including the
one that matters most: fzf finds nothing
by itself. It only ever ranks the list
you fed it, so the feeding is half the
skill.

One rule runs through the chapters that
act on a choice, and it is stated in
chapter 1: **a selection is not a
command.** fzf prints a name; what some
other program then does with that name —
open it, copy it, delete it — is a
separate decision, and this guide builds
the habit of reading the name once before
anything acts on it, especially when the
list came from somewhere you do not
control.

The lab behind this guide ran the real
thing: **fzf 0.74.5**, the project's own
release binary, on a small Linux machine,
against a practice tree the lab built
for the purpose — twenty-seven small
files in three folders: invented
documents, song names and photo names,
nobody's real papers. Against it the lab
ran fzf's scriptable half for real:
`--filter` searches in the fuzzy and
exact modes, the whole query language of
quotes, anchors and *not*, the printed
query, multi-select output, the exit
codes for a match, for no match and for
a bad option — measured, not quoted — a
grep-fed search that finds lines inside
files, two small scripts that act on a
choice, and the shell integration script,
loaded and inspected. It also recorded
its own stumble honestly: a feeder that
silently dropped a line over one capital
letter (transcript t90).

What the lab could not do, it did not
fake. The interactive window — the
full-screen list you type into — cannot
be driven or transcribed in the lab's
sandbox, so the window, its keys, the
preview pane, and the Ctrl-R, Ctrl-T and
Alt-C keypresses are taught from the
project's documentation and from the
integration script itself, and labelled
as such wherever they appear. Everything
those features *do* to a list is the same
matching the lab verified through
`--filter`. `criteria.md` keeps the full
ledger of what was run and what was only
read.

## What this guide covers

- [**What fzf is**](what-fzf-is.md) —
  the mental model: a filter, not a
  finder; fuzzy matching; and the
  one safety rule about acting on a
  selection
- [**The moving parts**](the-moving-parts.md) —
  the list, the query, fuzzy matching
  and the score, the preview, and key
  bindings, and which part holds what
- [**Installing fzf**](installing-fzf.md) —
  packages, the project's installer,
  and the release binary, with the
  version check that proves the install
- [**Your first search**](your-first-search.md) —
  a first list from `find`, a first
  query, reading the results in score
  order, and the same search with no
  window at all
- [**Finding files**](finding-files.md) —
  feeding fzf from `find`, matching on
  the name alone with `--nth`, and
  choosing folders as well as files
- [**Command history with Ctrl-R**](command-history.md) —
  the history widget: how a list of
  everything you ever typed becomes
  the quickest way to run it again
- [**Searching inside files**](searching-inside-files.md) —
  a grep-fed list that finds lines by
  their contents, and the case trap
  that decides what fzf never sees
- [**fzf in scripts**](fzf-in-scripts.md) —
  `--filter`, `--print-query`, the
  exit codes measured for real, and
  quoting a choice so a script acts on
  exactly the line that was chosen
- [**Previews**](previews.md) —
  looking inside the highlighted line
  before choosing it: the preview
  command, its placeholders, and the
  pane that shows it
- [**Multi-select and acting on choices**](multi-select-and-acting.md) —
  choosing several lines with `-m`,
  and the loop that acts on each one
  safely
- [**Options and FZF_DEFAULT_OPTS**](options-and-defaults.md) —
  the options worth knowing, and the
  two environment variables that carry
  your defaults — each measured, not
  just listed
- [**Shell integration and key bindings**](shell-integration.md) —
  the one line that installs Ctrl-R,
  Ctrl-T and Alt-C, what those widgets
  are, and the variables that tune them
- [**Recipes**](recipes.md) — open the
  file you half-remember, jump to a
  folder, copy the chosen few, find
  the line and then the file, and more
- [**The neighbours**](the-neighbours.md) —
  `find` and `fd`, `grep` and ripgrep,
  `locate`, tab completion, pickers
  and launchers: what each does that
  fzf doesn't, and vice versa
- [**Limits**](limits.md) — the feeder
  decides the universe, fuzzy is not
  understanding, the list is lines
  and nothing more, and the acting
  rule, stated plainly
- [**Troubleshooting**](troubleshooting.md) —
  the match that should exist, the
  empty window, the script that hangs,
  the wrong line acted on, and the
  traps this guide's lab fell into so
  you don't have to
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

fzf's HTTP server mode (`--listen`),
which lets other programs drive a running
fzf, and its use as a building block
inside other tools' interfaces — both
real, both a second book. Writing custom
key bindings beyond a first taste, and
the full scoring algorithm's internals,
are pointed at, not taught; the project's
own manual is the reference there. This
guide also does not teach the feeders
themselves beyond what a list needs:
`find` and text processing each have
their own guides in this series, pointed
to once each, and every chapter here
completes without them.

## How to use this guide

Read chapter 1 for the model and the
rule, and chapter 2 before installing
anything — knowing which part holds what
turns later confusion into a named
problem. Chapter 4 runs your first search
in the same sitting as the install, in
`--filter` mode first so the matching
itself is visible as plain output, then
in the window. Chapters 5 to 7 are the
three lists everyone ends up searching —
files, history, file contents. Chapter 8
is the one that turns a convenience into
an instrument: once fzf is in your
scripts, its exit codes matter as much as
its matches. The lab's transcripts live
in `fzf-lab/transcripts/`; its practice
tree is `fzf-lab/sample-tree/` (rebuilt
any time by `fzf-lab/build-sample-tree.sh`);
its scripts are `fzf-lab/scripts/`; its
notes are `examples/lab-notes.txt`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [Finding Files for Mere Mortals](https://paulsullivan33-dev.github.io/finding-files-for-mere-mortals/)
- [Bash for Mere Mortals](https://paulsullivan33-dev.github.io/bash-for-mere-mortals/)
- [Text Processing for Mere Mortals](https://paulsullivan33-dev.github.io/text-processing-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/fzf-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/fzf-for-mere-mortals/blob/main/LICENSE-CODE).
