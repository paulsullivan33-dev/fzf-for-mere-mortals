# Glossary

**Anchor** — `^` and `$` in a query,
tying a piece to the start or end of
the whole line — path included
(chapter 4).

**Choice / selection** — the line (or
lines) fzf prints when it finishes.
What happens to it next is the
caller's business, and chapter 1's
rule.

**Delimiter** — the pattern
(`--delimiter`) that splits a line
into fields for `--nth` and the
numbered preview placeholders
(chapters 5 and 9).

**Exact match** — matching whose
letters must sit side by side, as a
substring. In a query, a piece
starting with `'`; as a mode, `--exact`
(chapters 2 and 11).

**Exit code** — fzf's report to a
script: 0 a match or a choice, 1 no
match, 2 an error, 130 interrupted
(chapter 8).

**Extended search** — the query
language of chapter 2: pieces,
quotes, anchors, `!` and `|`. On by
default; `--no-extended` turns the
whole query into one fuzzy piece.

**Feeder** — the program whose output
is fzf's list: `find`, `grep`, `ps`,
the shell's history. It decides what
exists (chapters 2 and 15).

**Filter mode** — running with
`--filter`: no window, matches
printed, exit code speaking. The
script face (chapters 4 and 8).

**Fuzzy matching** — matching whose
letters need only appear in order, not
side by side: `anrp` fits
`annual-report` (chapter 2).

**FZF_DEFAULT_COMMAND** — the command
whose output becomes the list when
fzf starts at a terminal with no
piped input (chapter 11).

**FZF_DEFAULT_OPTS** — options read by
every run before the command line's
own; measured in chapter 11 to change
a query's fate on its own.

**Info line** — the window's counter,
`2/27`: matches over list size.

**List** — the lines fzf is given,
one candidate per line. The unit of
everything (chapter 2).

**Marker** — the margin sign on a
line marked with Tab under `--multi`
(chapter 10).

**Multi-select** — `-m` / `--multi`:
several lines chosen and printed. In
filter mode it means *print every
match* (chapter 10).

**nth** — `--nth`: the fields of each
line the matching may look at.
`--with-nth`: the fields used to
*display* the line instead. Chapter 5
matches on the name alone with
`--nth -1`.

**Placeholder** — in a preview
command, a token fzf replaces: `{}`
the highlighted line, `{q}` the
query, `{+}` the chosen lines, `{1}`
the first field (chapter 9).

**Preview** — the pane beside the
window's list showing a command's
output for the highlighted line
(chapter 9).

**Print0 / read0** — `--print0` and
`--read0`: NUL characters instead of
newlines between items, for names no
newline can be trusted around
(chapter 10).

**Print-query** — `--print-query`:
the query printed as output line one,
ahead of the matches (chapter 8).

**Query** — what you type: one or
more pieces, fuzzy by default, with
the small grammar of chapter 2.

**Scheme** — a named set of scoring
rules: `default`, `path`, `history`
(chapters 2 and 11).

**Score** — the number a matching
line earns for closeness,
word-boundaries and brevity, deciding
the output order (chapter 2).

**Smart case** — the case rule: an
all-lower-case query matches any
case; one capital makes it
case-sensitive (chapters 2 and 16).

**Subsequence** — letters in order,
not necessarily adjacent. The shape a
fuzzy piece must find in a line.

**Tiebreak** — what decides between
equal scores; line length by default
(chapter 11).

**Walker** — the built-in folder
walker recent fzf versions use for
their default list, with its own skip
rules (`--walker`) (chapter 11).

**Widget** — a shell function wired
to a key by the integration:
`__fzf_history__` (Ctrl-R),
`fzf-file-widget` (Ctrl-T),
`__fzf_cd__` (Alt-C) (chapter 12).
