# What fzf Is

You have a list. It is longer than your
memory of it: every file under a folder,
every command you have run this month,
every line that mentions a word in a
pile of documents. You remember fragments
of the entry you want — *report*, *2024*,
something about a *bridge* — but not the
whole name, and scrolling is not a plan.

**fzf is a filter for lists.** You hand
it lines of text on its standard input.
It shows you the lines that fit what you
type, best first, and when you choose
one, it prints that line to its standard
output and stops. That is the whole
contract, and everything in this guide —
the window, the history search, the
scripts — is built on it.

The matching is **fuzzy**. The letters
of your **query** do not need to appear
side by side in a line; they need to
appear *in order*. Type `anrp` and fzf
offers `annual-report-2024.txt`, because
a-n-r-p walk through it in order, with
other letters in between. Lines where
the letters land closer together, or at
the start of a word, are scored higher
and float to the top — which is why the
answer you meant is so often already
highlighted when you stop typing.

## Why anyone would do this

Four honest reasons account for nearly
every use:

- **Finding files.** `find` can list ten
  thousand files and cannot tell you
  which one you meant. fzf is the telling
  part (chapter 5).
- **Reusing commands.** Your shell history
  is a list of everything you have ever
  figured out how to type. With fzf behind
  Ctrl-R, re-running last month's long
  command is a few letters and a glance
  (chapter 6).
- **Searching contents.** Feed fzf the
  lines a search *found*, and pick the one
  you want by eye instead of by memorised
  line number (chapter 7).
- **Scripting.** With no window at all,
  fzf's `--filter` mode answers "which of
  these lines fits?" for a script, and its
  exit code answers "did anything fit?"
  (chapter 8). This guide's lab verified
  that half by running it.

## The rule, stated before everything else

fzf itself does nothing to anything. It
prints a line. The danger, such as it is,
lives one step later, when a script or a
shell takes that printed line and *acts*
on it — opens it, copies it, runs it,
deletes it. So this guide has one rule,
and it is not fine print:

> **A selection is not a command. Read
> the line fzf printed before anything
> acts on it, and never pipe a selection
> you have not read into a shell to be
> executed.**

The everyday shape of the rule: when a
pipeline you are building would end in
something destructive, run it first with
`echo` where the destructive verb will
go, and read what it *would* do. Only
then swap in the real verb. Chapters 8,
10 and 15 return to this, because the
pipelines where it matters most —
`rm`, `kill`, running a chosen line as a
command — are exactly the pipelines fzf
makes easy to write. A list built from
names you do not control (a downloaded
archive's contents, another program's
output) deserves the same suspicion: the
names are data, not instructions.

## A familiar shape

fzf has two faces, and they share one
engine:

- **The window.** Run at a terminal, fzf
  opens a full-screen list. You type, it
  narrows; arrow keys or Ctrl-K and
  Ctrl-J move; Enter accepts; Esc or
  Ctrl-C abandons. This is the face most
  people meet first, and chapters 4 to 7
  live in it.
- **The script face.** `--filter=QUERY`
  never opens a window: it prints the
  lines that match and exits, with an exit
  code that says whether anything did.
  Scripts use this face, and this guide's
  lab used it for every measurement,
  because printed output can be kept in a
  transcript and checked.

There is also a third presence: the
**shell integration** (chapter 12), which
puts fzf behind three keys in your shell
— Ctrl-R for history, Ctrl-T for file
names, Alt-C for folders — each one a
small feeder program handing fzf a list.

A first taste, after installing
(chapter 3), against this guide's
practice tree of twenty-seven files:

```bash
find . -type f | sort | fzf --filter=report
```

```text
./documents/annual-report-2023.txt
./documents/annual-report-2024.txt
```

Two lines fit the letters r-e-p-o-r-t,
and fzf printed them, best first. The
interactive version of the same search —
`find . -type f | fzf` — shows all
twenty-seven lines and lets you watch
them shrink to those two as you type.
The lab's full first session is
transcript `fzf-lab/transcripts/t01-first-filter.txt`.

Check: run the command above in the
practice tree (`fzf-lab/sample-tree/`).
You should see exactly those two lines,
in that order.

## Who it is for

Anyone who works in a terminal and has
ever typed a file name wrong twice in a
row; anyone whose history is longer than
their memory; anyone whose scripts keep
asking a human a question a list could
answer. The common thread is one person,
a long list, and a fragment of memory
that turns out to be enough.

## What it is not

fzf is not a file finder in itself: it
searches nothing, indexes nothing, and
caches nothing. Left alone at a terminal
it will list the files under the current
folder for you (recent versions walk the
tree themselves), but the moment you pipe
a list into it, the list is *yours* —
built by `find`, by `grep`, by whatever
you trust — and fzf only ranks it. A
file your feeder never printed is a file
fzf cannot offer you, a fact chapter 7's
trap makes vivid. It is not a search
engine for contents either: it ranks
whole lines by how their letters fit
your query, not by meaning — chapter 15
shows it confidently offering a photo of
a cat when you asked for a report. And
it is not a launcher or a file manager:
choosing a line and *doing something*
with it are two steps, and this guide
keeps them separate on purpose.
