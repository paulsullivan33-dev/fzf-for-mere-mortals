# fzf in Scripts

Everything so far works at a terminal,
with a human reading the list. This
chapter is the other half of the tool:
fzf inside a script, where nobody is
looking and the program must say what
happened in a form the script can act
on. The outcome: you can ask "which of
these lines fits?" and "did anything
fit?" from a script, and handle every
answer — including *none* — without
surprises.

## --filter: the window, without the window

`--filter=QUERY` is the core of it. It
prints the matching lines — best first,
exactly as chapter 4 measured — and
exits. No terminal is needed, no
keystroke is waited for. A script that
asks "the report file, whichever year
is newest in score order" is one line
of asking and one of taking the first
answer:

```bash
find . -type f | sort | fzf --filter=report | head -n 1
```

`--query=QUERY` is the other spelling of
a nearby idea: it *pre-types* the query
in the interactive window, for a human
to refine. Scripts that use `--query`
are scripts with a person in them;
scripts without people use `--filter`.

## The exit codes, measured

A script cannot see a window; it can
see an exit code. fzf's are few and
they mean exactly what chapter 2
promised. The lab measured each one it
could reach without a keyboard
(transcript `fzf-lab/transcripts/t06-exit-codes.txt`):

| Situation | Code | Lab evidence |
|---|---|---|
| At least one line matched | 0 | `--filter=report` |
| Nothing matched | 1 | `--filter=zzzz` |
| Empty list, so nothing could match | 1 | `printf '' \| fzf --filter=x` |
| Bad option | 2 | `fzf --frobnicate` → `unknown option`, code 2 |
| You pressed Esc or Ctrl-C in the window | 130 | Documented only — it needs a hand |

Two habits follow. First, **no match is
a result, not a failure**: a script
running under `set -e` will die at a
perfectly healthy "nothing matched"
unless the script treats code 1 as an
answer (`if chosen=$(...); then ...`
does, because the `if` consumes the
code). Second, code 130 belongs to the
interactive world — a person changed
their mind — and a script that launches
the window should let it mean *stop*,
not *retry*.

A wrinkle the lab measured because
intuition gets it wrong: `--exit-0`
("exit 0 when there is no match") does
not change the code in `--filter` mode —
no match still exits 1 (transcript
t06). `--exit-0` and its sibling
`--select-1` govern the *window's*
behaviour (leave at once when there is
nothing, or exactly one thing, to show).
Script authors reaching for them to fix
an exit code are fixing the wrong layer;
handle the 1.

## --print-query: when the question is also data

Sometimes the script needs to know what
was *asked*, not only what matched —
a search box that remembers, a log of
what people looked for. `--print-query`
prints the query as the first output
line, ahead of any matches:

```text
$ find . -type f | sort | fzf --filter=report --print-query
report
./documents/annual-report-2023.txt
./documents/annual-report-2024.txt
```

(from transcript
`fzf-lab/transcripts/t04-print-query-and-env.txt`).
Note the no-match shape in the same
transcript: the query is *still*
printed, alone, with exit code 1 — so
a reader of `--print-query` output
takes the first line as the question
and treats "no further lines, code 1"
as its answer. Scripts that forget the
extra line and feed all output onward
as if it were choices will one day act
on the word `report` as if it were a
file. Order in the output is part of
the contract; read the contract.

## A choice is a string; treat it like one

The lab's script, `fzf-lab/scripts/pick-a-recipe.sh`,
is the chapter in working form:

```bash
pattern=${1:-pancakes}
choice=$(find . -name 'recipe-*.txt' | sort | fzf --filter="$pattern" | head -n 1)
if [ -z "$choice" ]; then
  echo "no recipe matched '$pattern'" >&2
  exit 1
fi
cat "$choice"
```

Three decisions in it are worth naming,
because every fzf script needs all
three:

- **The choice is captured, then
  tested.** An empty choice — nothing
  matched — is handled on purpose,
  with a message and an exit, instead
  of flowing onward into `cat ""`.
- **The choice is quoted everywhere it
  is used.** `"$choice"`, never
  `$choice`: a file named with spaces
  is one choice and must stay one
  argument (chapter 10 has the
  NUL-separated form for names stranger
  than spaces).
- **The selection is never executed.**
  It is opened, printed, counted —
  whatever the script's job is — but a
  line from a list is data, and chapter
  1's rule is the reason `eval` should
  never appear on the right of an fzf
  pipeline.

Its runs, including the honest failure,
are transcript
`fzf-lab/transcripts/t08-act-on-choice.txt`:
`./scripts/pick-a-recipe.sh` prints the
pancakes recipe; `... soup` prints the
soup; `... zzzz` prints `no recipe
matched 'zzzz'` to standard error and
exits 1 — the script doing with fzf's
answer exactly what this chapter
describes.

Check: the exit codes in the table are
transcript t06's, and the script's
three behaviours are transcript t08's.
Nothing in this chapter needs a window;
that is rather the point of it.
