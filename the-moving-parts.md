# The Moving Parts

fzf looks like one small program and
behaves like five parts working together.
Knowing which part holds what is the
difference between "fzf is broken" and
"my feeder never listed that file" — a
real distinction, as this guide's own
lab learned (chapter 16).

## The list

Everything starts as **lines on standard
input**. Another program prints them —
that program is the **feeder** — and fzf
reads them, one line per candidate. The
line is the whole unit: fzf does not know
or care that a line is a file name, let
alone where the file lives. Three
consequences run through the guide:

- The feeder decides the universe. If a
  line is not printed by the feeder, it
  does not exist for fzf (chapter 7's
  trap, transcript t90).
- The line is what you get back. When a
  line carries extra information — a file
  name, a line number and a matched text,
  as a `grep` feeder prints — all of it
  comes back with the choice, ready to be
  taken apart (chapter 7).
- Odd characters ride along. A name with
  spaces is one line and one choice, as
  long as every program in the pipeline
  treats it as one — chapter 10 shows the
  quoting and the NUL-separated form
  (`--print0`) that keep it one.

Where does the list come from when you
pipe nothing in? Only at a terminal: then
fzf runs a default listing — recent
versions walk the folder tree themselves;
older ones ran a `find` command — and the
`FZF_DEFAULT_COMMAND` variable
(chapter 11) replaces that listing with
one of yours. In a script, with input
piped or redirected, there is no default:
piped input *is* the list.

## The query

The **query** is the text you type, or
the text after `--filter=`. It is not
one word but a small language
(chapter 4 uses it, transcript t02
measures it):

| You type | It means |
|---|---|
| `report` | fuzzy match: the letters, in order, anywhere |
| `'report` | exact match: the letters side by side, as a substring |
| `^report` | the line starts with these letters |
| `report$` | the line ends with these letters |
| `!report` | the line does *not* contain these letters |
| `report \| recipe` | either side may match (or) |
| `report 2024` | both must match (and) |

Case has a rule of its own, called
**smart case**: a query typed all in
lower case matches any case, so `report`
finds `Report` too. Type one capital and
the query becomes case-sensitive — the
lab's `Annual` matched nothing at all in
a tree full of `annual` (transcript
t02). Chapter 16 starts there when a
match "should" exist.

## The match and the score

Each line that fits is given a **score**.
The details are the project's own, but
the shape is simple and worth knowing,
because it explains the order you see:
letters that land together score more
than letters spread out; letters at the
start of a word — after a `-`, a `_`, a
`/` or a space — score more than letters
buried mid-word; shorter lines beat
longer ones when the fit is otherwise
equal (the default tie-break is length).
That is why, feeding the practice tree
the query `2024`, the lab got
`budget-2024.txt` *above*
`annual-report-2024.txt` (transcript
t01): both contain the same four digits,
and the shorter line won.

The score's rules can be swapped as a
set — a **scheme**. The default scheme
favours close fits; the `path` scheme
expects file paths and favours matches
in the last part, the name; the `history`
scheme drops the bonuses so a history
list stays in its own order of recent
use. Chapter 11 shows where schemes are
set; for most days the default is right.

## The preview

In the window, a **preview** shows the
inside of the highlighted line — the
file's contents, say — in a pane beside
the list, before you commit to choosing
it. The preview is a shell **command**
you supply, with a placeholder, `{}`,
standing for the highlighted line
(chapter 9). It is the only part of fzf
that runs other programs while you are
still deciding, which is why chapter 9
insists the command be cheap and read-only
by habit: it runs again at every movement
of the highlight.

The preview lives entirely in the
window. In `--filter` mode there is no
pane and no preview — the lab passed a
`--preview` flag in filter mode and the
output was simply the match, the flag
unacted-on (transcript t10). What the lab
could verify about previews is the
command itself, and chapter 9 says so.

## Keys and actions

Inside the window, keys move (Ctrl-K and
Ctrl-J, or the arrow keys), mark
(Tab, with `--multi`), accept (Enter) and
abandon (Esc, Ctrl-C). Keys can be
**rebound** with `--bind` to run actions
— toggle the preview, reload the list,
run a command — which turns fzf from a
picker into a small interface. That craft
is beyond this guide's scope; what
matters here is the contract on the way
out. When you accept, fzf prints the
accepted line (or lines) to standard
output and exits **0**. When nothing
matches, or you abandon, it prints
nothing and the exit code says which
happened: **1** for no match, **130**
for interrupted-by-you, **2** for an
error such as a bad option. Chapter 8
measures all of these but 130, which
needs a hand on a keyboard, and chapter 8
is where a script learns to read them.

## Who holds what, when it breaks

- The **feeder** holds the truth about
  what exists. A missing line is the
  feeder's doing, nine times in ten.
- The **query** holds the truth about
  what fitted. Smart case and anchors
  explain most "impossible" misses.
- The **score** holds the order. If the
  right line is present but low, the
  query is too loose — add a word
  (chapter 4's *and*).
- The **caller** — you, or your script —
  holds what happens next. fzf's
  responsibility ends at printing the
  line; chapter 1's rule starts there.
