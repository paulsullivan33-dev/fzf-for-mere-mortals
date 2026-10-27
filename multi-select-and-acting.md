# Multi-Select and Acting on Choices

One chosen line is a lookup. Several
chosen lines are a *job*: these six
photos to copy, these three reports to
mail, these two recipes to print. This
chapter's outcome: you can choose many
lines at once, and run one action per
chosen line with the names intact —
spaces and all — and with the safety
habit that makes batch actions boring
instead of memorable.

## Choosing several

Add `-m` (long form `--multi`) and the
window gains marking: **Tab** toggles
the mark on the highlighted line and
moves down, **Shift-Tab** toggles and
moves up, marked lines carry a marker
in the margin, and Enter prints all of
them, in score order.
(The keys are the window's, so they sit
in this guide's documented-only column;
everything they *produce* — the stream
of chosen lines — is what the rest of
the chapter verifies.)

In `--filter` mode there is no marking
to do, so `--multi` takes the other
reasonable meaning: *print every match*,
not just the best. That is the
scriptable stand-in for "tick them
all", and it is what the lab measured
(transcript `fzf-lab/transcripts/t05-multi-select.txt`):

```text
$ find . -type f | sort | fzf --multi --filter=recipe
./documents/recipe-pancakes.txt
./documents/recipe-tomato-soup.txt
$ find . -type f | sort | fzf --multi --filter='report | recipe' | wc -l
4
```

A cap exists when a job should not grow
legs: `--multi=3` allows at most three
marks in the window.

## Acting, one line at a time

The shape that survives contact with
real names is a loop that reads whole
lines, quoted everywhere:

```bash
find . -type f | fzf --multi |
while IFS= read -r chosen; do
  printf '%s\n' "$chosen"
done
```

The lab's working version,
`fzf-lab/scripts/word-count-of-chosen.sh`,
puts a real action in the loop's body —
count the words in each chosen text
file — driven by `--filter` so it runs
unattended (transcript
`fzf-lab/transcripts/t08-act-on-choice.txt`):

```text
$ ./scripts/word-count-of-chosen.sh report
./documents/annual-report-2023.txt: 20 words
./documents/annual-report-2024.txt: 20 words
$ ./scripts/word-count-of-chosen.sh budget
./documents/budget-2024.txt: 15 words
./documents/budget-2025.txt: 15 words
```

The details doing the work: `IFS=`
stops the shell trimming spaces off the
ends of a name; `read -r` stops it
eating backslashes; `"$chosen"` is
quoted at every use. Leave any one out
and some name, someday, is two arguments
or half a name — chapter 16 collects
the symptoms.

## When lines are not enough: NUL

A line-based list cannot hold a name
that itself contains a newline. Such
names are rare and usually accidental,
but the pipeline that *cannot* be
fooled is worth knowing exists:
`--print0` separates fzf's output with
NUL characters instead of newlines,
`--read0` accepts the same on input,
and the consumers are `while read -d ''`
loops and `xargs -0`. The lab printed a
two-invoice selection in `--print0`
form and displayed it through `tr`
(transcript t05) — through NULs the
invoices arrived as two items, exactly
as the newlines form would lose if a
name ever contained one. Reach for
NUL when the names come from somewhere
you do not control; it is chapter 1's
rule in mechanical form.

## The acting rule, at batch scale

Chapter 1's rule — *read the selection
before anything acts on it* — matters
most here, because multi-select is
where destructive verbs get efficient.
The habit this guide teaches, without
exception in its own examples: **build
the pipeline with `echo` first.**

```bash
find . -type f | fzf --multi | xargs -d '\n' echo rm
```

Read the printed commands as a list of
intentions. If every line is one you
would run yourself, remove the `echo`
and run it again — and not before. The
two-step feels slow exactly once; the
alternative also feels slow exactly
once, and then for longer. A selection
is data. A batch is a selection with
momentum. The reading is the job.
