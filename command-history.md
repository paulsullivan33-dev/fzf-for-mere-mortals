# Command History with Ctrl-R

Every shell keeps a list of the commands
you have run. Most people's entire
relationship with it is pressing the up
arrow and hoping. This chapter gives you
the other relationship: press **Ctrl-R**,
type a few letters from anywhere in the
command — the tool's name, a word from
the middle, the file it acted on — and
watch your own history narrow to the
command you meant. The outcome is not
just convenience. A long command you
built once, with the right options in the
right order, is a piece of work. Ctrl-R
is how you stop rebuilding it from
memory and getting one flag wrong.

## What the key does

Ctrl-R is not built into your shell. It
is installed by fzf's shell integration
(chapter 12 is the install, and the
proof it landed), and what it installs
is a **widget** — a small shell function
wired to the key — whose whole job is
the pipeline of chapter 2, run on a
particular list:

1. The list is your history, newest
   first, duplicates removed.
2. fzf's window opens over that list —
   the same window as chapter 4, fed
   from behind.
3. You type a query, the list narrows,
   Enter accepts a line.
4. The chosen command is placed on your
   command line, *as text*. Nothing has
   run. Read it — chapter 1's rule in
   its most everyday form — edit it if
   the old occasion differs from this
   one, and press Enter yourself to run
   it.

Step 4 is the design in miniature:
history search that *inserts* rather
than executes, so the final decision
stays with the human who can see the
whole line.

Honesty, per this guide's habit: a
keypress in an interactive shell cannot
be driven or transcribed in the lab's
sandbox, so the widget's behaviour above
is taught from the project's
documentation and from the integration
script itself. What the lab verified is
that the script is real and loads: after
evaluating `fzf --bash`, a live shell
reports the history widget — `__fzf_history__`
— present as a function (transcript
`fzf-lab/transcripts/t09-shell-integration.txt`),
alongside its siblings for Ctrl-T and
Alt-C. And the matching the widget
performs is chapter 4's, measured in
full: a history list is lines, a query
is a query, whichever feeder printed
them.

## Using it well

- **Search by the rare word.** The
  command you want shares most words
  with fifty others; it differs by one —
  the unusual host, the odd file name,
  the flag you only ever used there.
  Query that word.
- **Two words narrow fastest.** The
  *and* of chapter 4 works in the
  history window exactly as in a filter:
  the tool's name plus the rare word is
  usually a list of one.
- **Expect duplicates to be gone.** The
  widget de-duplicates the history it is
  fed, so the command you ran nine times
  appears once, at its most recent
  position. If you go looking for the
  *older* twin, it is not there — that
  is the widget tidying, not your memory
  failing.
- **The newest match is pre-highlighted,**
  which is right for history: you usually
  want the latest form of a command, and
  the `history` scoring scheme
  (chapter 2) keeps the list's own
  recency ahead of fuzzy cleverness.

## Tuning it, lightly

The widget answers to variables, all
optional, all set in your shell's
startup file (`FZF_CTRL_R_OPTS` is the
one for this key; chapter 12 has the
family): extra fzf options for this
widget only. Two worth knowing: the
widget copies the chosen line's history
number handling for you — what lands on
your command line is the command, not
its index in the history file — and the
shell's own history settings (how much
history is kept at all, `HISTSIZE` and
its friends) belong to the shell, not
to fzf. A Ctrl-R that finds little is
usually a history that *keeps* little,
and chapter 16 says so again.

## The same trick by hand

The widget is a convenience, not a
gatekeeper. The list it searches can be
printed by any shell — `history` in
bash, `fc -ln 1` for bare commands — and
piped to fzf like any other list, which
is how you would search history from a
script, or on a machine where the
integration is not installed:

```bash
history | fzf
```

The lines arrive wearing their history
numbers, and the number comes back with
your choice — one reason the widget,
which strips and tidies, is the nicer
daily tool, and the pipe is the proof
that no magic is involved.

Check: with the integration loaded
(chapter 12), Ctrl-R opens a window over
your recent commands; type the name of
a tool you used earlier today and its
commands gather. If nothing opens, the
integration is not loaded in *this*
shell — chapter 16 has the checklist.
