# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's tree is invented, its documents are a few lines
   long, and nothing in it is anybody's real papers.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 15 names what the tool
   cannot do: it searches nothing by itself and the feeder
   decides the universe, fuzzy matching is spelling and not
   understanding, the list is lines and not records, and a
   selection fed carelessly onward is a hazard the tool
   cannot see, let alone stop.
8. **The safety rule is in the text, early.** Chapter 1 and the
   README state the rule plainly — *a selection is not a
   command: read the line fzf printed before anything acts on
   it, and never pipe a selection into a shell to be
   executed* — before any procedure depends on it, and
   chapters 8, 10 and 15 return to it where the tooling
   would make crossing the line easy.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is a 2-CPU, 7.7 GB Ubuntu 24.04 sandbox.
fzf **0.74.5** — the project's official release binary for
Linux amd64, unpacked into the sandbox — was exercised
against a practice tree built for this guide
(`fzf-lab/sample-tree/`, rebuilt from scratch at any time by
`fzf-lab/build-sample-tree.sh`): twenty-seven files in three
folders. The release binary was used because the build
machine's package manager was locked by another process
throughout the lab; the binary is the project's own build,
and every option the chapters teach was checked against its
`--help` output. All transcripts live in
`fzf-lab/transcripts/`; the scripts are `fzf-lab/scripts/`.

Run for real, with transcripts as evidence:

- Version, and the practice tree's file count (t00).
- First searches in `--filter` mode: fuzzy `report`, the
  subsequence query `anrp` with its three honest strays,
  and `2024` returning score order rather than input order
  (t01).
- The query language: `^` anchoring against the whole line
  (a measured no-match on paths), `.mp3$`, `!mp3` counted,
  `report | recipe` for *or*, two words for *and*, smart
  case (a capital query matching nothing), and `--exact`
  refusing the subsequence query (t02).
- Finding files: words combined across folder and name,
  a feeder pre-filtered by extension, name-only matching
  with `--delimiter / --nth -1` — including the proof that
  a folder word then matches nothing — and a folders-only
  list (t03).
- `--print-query` with and without a match, the
  `FZF_DEFAULT_OPTS=--exact` contrast (the same query
  failing and then matching five, nothing changed but the
  environment), and `FZF_DEFAULT_COMMAND` feeding fzf
  under a pseudo-terminal, which is the condition the
  variable requires (t04).
- Multi-select output in filter mode and the `--print0`
  form, shown through `tr` (t05).
- Exit codes, measured: 0 for a match, 1 for no match,
  1 for an empty list, 1 for no match *with* `--exit-0`
  (it does not do what its name suggests in filter mode),
  2 with the `unknown option` message for a bad flag (t06).
- The grep feeder: three content lines found with
  `grep -rin`, then picked from by file word and by
  content word (t07).
- Two scripts acting on choices end to end, including
  the no-match run that reports and exits 1
  (`fzf-lab/scripts/`, t08).
- The shell integration: `fzf --bash` generated (939
  lines), and a live interactive shell reporting the
  history, folder and file widgets present as functions
  after evaluating it; the zsh and fish variants
  generated as well (t09).
- The preview's scriptable half: `--preview` accepted and
  ignored in filter mode, and the preview command for the
  chosen line run by hand (t10).
- The lab's own stumble, kept whole: a `grep` feeder
  without `-i` silently withholding the shopping list's
  capitalised line, so an fzf search "failed" on a line
  it never received (t90).

Documented only — described from the project's
documentation, not run, and the text does not claim
otherwise:

- The interactive window itself: its appearance, the
  highlight, matched-letter highlighting, and its keys
  (type to filter, Ctrl-K/Ctrl-J and arrows to move,
  Enter, Esc). A terminal UI in this sandbox leaves no
  transcript to keep; every *result* the window
  produces is the matching the lab verified through
  `--filter`.
- The Ctrl-R, Ctrl-T and Alt-C keypresses and the
  `**` completion trigger (chapter 12). The widgets'
  presence in a live shell is the verified half;
  the keystrokes are not.
- The preview *pane* — its placement, sizing and
  toggle binding (chapter 9). The preview *command*
  was run; the pane was not seen.
- Exit code 130 (interrupted in the window), which
  needs a hand on a keyboard.
- The packaged and installer routes of chapter 3 on
  other systems (Windows, macOS), and older versions'
  `key-bindings` files; the lab's one route — the
  release binary — is the run one.
- The comparison tools in chapter 14 are
  characterised, not benchmarked.

Fixtures are this guide's own and deliberately generic:
twenty-seven invented files — garden-club reports and
budgets, two recipes, a shopping list, a holiday plan,
song names and photo names that name nothing real. No
example is modelled on any real person, network, service
or organisation, and every list the lab filtered was a
list the lab itself printed.
