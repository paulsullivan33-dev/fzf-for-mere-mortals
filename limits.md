# Limits

What fzf cannot do, and what it must
not be asked to do — the chapter the
rest of the guide has been promising.

## The feeder decides the universe

The deepest limit, and the one behind
most real-world confusion: **fzf
searches only the lines it was given.**
It has no index, no memory of previous
lists, no crawl of its own in pipe
mode. Consequences that are all the
same consequence:

- A file the feeder skipped — hidden
  by a flag, pruned by a pattern, never
  printed because the searcher was
  case-sensitive (chapter 7, transcript
  t90) — does not exist for the query.
- A stale list is a stale world. fzf
  ranks the lines it read when it
  started; the tree can change under
  it, and a chosen name can be gone by
  the time anything acts on it. For
  fast human work this never matters;
  for a slow script acting on old
  choices, check the name still means
  what it meant (chapter 1's rule,
  wearing a watch).
- "fzf can't find my file" is, in
  practice, almost never about fzf.
  Chapter 16's first entry is the
  feeder, for this reason.

## Fuzzy is not understanding

The score rewards letter patterns,
not meaning. The lab's query `anrp`
brought back a song and a photograph
alongside the reports (transcript
t01) — correctly, by its rule — and no
option makes the rule semantic. fzf
does not know that `.txt` and `.mp3`
are *kinds* of thing, that 2024 is a
year, that the *budget* is probably
the document and the *photo* probably
not. All ranking is spelling. This is
a strength at 2 a.m. — the tool has
no opinions to be wrong with — and a
standing limit: the judgement in
every search is supplied by the human
reading the list, which is why the
interactive window, with a person in
it, remains the primary face, and why
a `--filter` script should want its
matches few and its pattern strict.

## The list is lines

One line, one candidate: the model
has no room for a record that spans
lines, for fields with types, for
"the same file, shown once" as a
concept (de-duplication is the
feeder's job, or the widget's, as
chapter 6's history shows). A name
containing a newline cannot even be
*one* candidate in the default form —
chapter 10's NUL modes move the
seams, they do not remove them.
Structured data — JSON, tables with
real columns — wants its own tools
first, and a list printed *from* it
second; feeding raw structure to fzf
and expecting field sense is asking
the spelling tool to do a database's
job.

## Size and speed, honestly

fzf reads the whole list into memory
(in `--filter` mode it reads to the
end of input before it can answer at
all) and scores against your query.
For the lists in this guide — a tree,
a history, a search result — that is
instant on any machine worth having.
For lists in the millions, the answer
depends on your setup: the list build
(the feeder walking a huge tree, a
database printing its rows) is usually
the slow half, and narrowing in the
feeder — a tighter `find`, a sharper
`grep` — beats any fzf option. There
are levers (`--tail` caps how much is
kept; the window streams while a
filter run cannot), but the honest
shape of the limit is: fzf is a tool
for lists a human means to choose
from, and lists beyond that scale are
a query engine's job, with fzf
welcome on the last hundred lines.

## The acting rule, as a limit

Chapter 1's rule belongs here too,
because it bounds what fzf should be
*asked* to feed. fzf prints a line out
of a list you provided. If the list's
provenance is doubtful — names from an
untrusted archive, lines from another
program's output you have not
inspected — the selection inherits the
doubt. Piping a selection into a shell
(`... | fzf | sh`) executes whatever
the list's author wrote, with your
permissions; word-splitting can
already smuggle extra arguments into
simpler verbs. None of this is a flaw
in fzf; it is the shape of a tool that
returns text and trusts the caller.
The limit to respect is your own
pipeline's: fzf ends at printing.
Everything after the print is yours,
and chapter 10's read-first habit is
the whole safety case.
