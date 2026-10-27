# The Neighbours

fzf sits in a crowded neighbourhood:
tools that list, tools that search,
tools that choose. An honest map of
which seat each one holds, because
half of using fzf well is knowing when
the answer is a different program.

## find, and fd

`find` is not fzf's rival but its usual
feeder — this series has a whole guide
to it (*Finding Files for Mere
Mortals*) — and the comparison still
matters: `find` answers exactly ("every
file newer than a day, larger than a
megabyte, named so") and cannot rank
by resemblance. `fd` is find's modern
neighbour: the same listing job with
friendlier defaults — hidden files and
`.gitignore`d paths skipped, colour,
speed — and it drops into every feeder
command in this guide unchanged. Reach
for the feeder when the criteria are
exact; for fzf when the criterion is
"I'll know it when I see most of it".

## grep, and ripgrep

The content searchers (chapter 7's
feeders). `grep` finds lines by pattern
with certainty and says nothing about
which line matters most; ripgrep does
the same job faster, skipping what
should be skipped by default. Neither
chooses. fzf is the choosing layer
that sits on either's output, and the
pairing — exact tireless finder, human
picker — is the pattern this guide
keeps returning to. A content search
with no picking step (a script that
needs *the* line, not *a* line)
belongs to the searcher alone, with
its pattern made precise.

## locate

`locate` answers from a database built
earlier (usually nightly by `updatedb`):
name fragments across the *whole
machine*, at a speed no walker matches.
Its costs are the mirror of fzf's
virtues: the database is as stale as
its last build — yesterday's file is
invisible, last month's deleted file
still glows — and it knows nothing of
the folder you are standing in. For a
name you half-remember *somewhere on
this machine*, locate's list is also a
fine feeder: `locate report | fzf`.

## Tab completion and **globbing**

The shell's own machinery: Tab
completes the *start* of a name you
are typing; glob patterns (`*2024*`)
expand exact shapes. Both are free,
instant and already in your fingers —
and both need you to know the
beginning, or the pattern, precisely.
fzf's niche is everything after that:
the middle of the name, two fragments
from different parts, a list too long
to complete through. They coexist
without rivalry; Ctrl-T (chapter 12)
is literally fzf wearing completion's
clothes.

## The smaller pickers: peco, fzy, skim

fzf is not the only fuzzy picker.
**peco** and **fzy** are smaller,
simpler Unix filters in the same
shape — lines in, a window, a choice
out — with fewer options and, in
fzy's case, a noticeably opinionated
scorer. **skim** (`sk`) is a close
relative in Rust, compatible in
spirit and much of the surface. If one
is already on your machine, this
guide's chapters — the feeder craft,
the query habits, the acting rule —
transfer nearly whole. fzf is taught
here because it is the one that is
everywhere, scripted by everyone, and
still actively growing the options
the others borrow.

## Launchers and menus: dmenu, rofi

The graphical cousins: give `dmenu`
(or `rofi`, its windowed heir) a list
and it offers the same type-to-narrow
choice in a desktop menu, returning
the line on standard output. The
pattern — a list, a fragment, a
selection, a script acting — is
identical, and a desktop full of
launchers is fzf's idea at the
operating system's scale. In a
terminal, though, they open windows
where fzf opens a pane, and the
terminal is this guide's home.

## zoxide

The neighbour that removes the
question: **zoxide** learns which
folders you visit and jumps you there
on a fragment — `z brid` — with no
list shown at all. When it guesses
right, nothing beats it; when the
fragment fits five places, you are
back to choosing, which is fzf's seat
(Alt-C, chapter 12). Learning versus
asking is a genuine fork in taste,
and many shells end up with both.
