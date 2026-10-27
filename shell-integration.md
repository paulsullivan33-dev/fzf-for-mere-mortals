# Shell Integration and Key Bindings

Everything in this guide so far is
something you *run*. The shell
integration turns three of fzf's best
lists into things you *press*: keys
that open fzf over the right list and
put the answer back into the command
you are typing. This chapter's outcome:
Ctrl-R, Ctrl-T and Alt-C working in
your shell, and a clear picture of what
was installed — because a line in your
startup file should never be a mystery
you pasted.

## The one line

Current fzf prints its own integration
script; your shell evaluates it. For
bash, in `~/.bashrc`:

```bash
eval "$(fzf --bash)"
```

For zsh, in `~/.zshrc`:
`eval "$(fzf --zsh)"`. For fish, in the
fish configuration:
`fzf --fish | source`. Open a new
shell (or source the startup file) and
the keys are live.

On an older fzf — the packaged ones of
chapter 3 — `--bash` may not exist.
Those versions ship the same scripts as
files instead: the `~/.fzf/install`
route of chapter 3 offers to wire them
up, and a manual install sources
`~/.fzf/shell/key-bindings.bash` (and
its zsh twin) from the startup file.
Same widgets, older plumbing; the
project's documentation for your
version is the authority on which.

## What gets installed

The lab generated the bash script and
counted it (transcript
`fzf-lab/transcripts/t09-shell-integration.txt`):
**939 lines**, comments and all. Its
own header names what it parameterises
— `$FZF_CTRL_T_COMMAND`, `$FZF_CTRL_R_OPTS`
and their siblings — and after a live
shell evaluates it, the widgets exist
as functions:

```text
$ bash --noprofile --norc -ic 'eval "$(fzf --bash)"; type -t __fzf_history__ __fzf_cd__ fzf-file-widget'
function
function
function
```

Three widgets, three keys:

| Key | Widget | The list | What happens to the choice |
|---|---|---|---|
| **Ctrl-R** | `__fzf_history__` | your command history, newest first, de-duplicated | placed on your command line to read and run yourself (chapter 6) |
| **Ctrl-T** | `fzf-file-widget` | files below the current folder | inserted as text at your cursor, mid-command |
| **Alt-C** | `__fzf_cd__` | folders below the current folder | your shell changes into it |

Ctrl-T deserves one concrete picture,
because it changes how commands get
written: type `cat `, press Ctrl-T,
type `brid`, Enter — and the command
line now reads `cat ./photos/the-old-bridge.jpg`,
the name inserted with the path as the
feeder printed it. You never typed the
name; you described it. (Some terminals
eat Alt-C for their own menus; on
those, the widget also answers to
Esc-then-C, and chapter 16 notes the
symptom.)

The keypresses themselves sit in this
guide's documented-only column, like
all the window's keys: the lab cannot
press keys in its sandbox. What it
verified — the script, its size, its
widget functions present and accounted
for in a live shell — is the part that
can be checked without fingers.

## The tuning variables

Each widget reads a pair of variables,
set in the same startup file:

- `FZF_CTRL_T_COMMAND`, `FZF_ALT_C_COMMAND` —
  the feeder for that widget's list,
  standing in for `FZF_DEFAULT_COMMAND`
  (chapter 11) where a widget wants a
  different list from the others.
- `FZF_CTRL_T_OPTS`, `FZF_CTRL_R_OPTS`,
  `FZF_ALT_C_OPTS` — extra options for
  that widget alone: a preview for
  Ctrl-T (`--preview 'cat {}'` is the
  classic) is set here, so the preview
  rides the key and not every fzf you
  run.

There is also completion: the same
installation teaches the shell to offer
fzf after a `**` typed in a command —
`cat **`, Tab — for paths, host names
and a few other lists. It is described
here, not measured; the everyday win is
the three keys, and completion is a
bonus that costs nothing to leave on.

## Removing it

Delete the line from the startup file
and open a new shell. Nothing else was
written anywhere: the widgets are only
ever functions in a shell that asked
for them.

Check: the transcript t09 test is the
check. If `type -t` answers `function`
for the three names in a fresh shell
with your startup file, the
integration is loaded; if it answers
nothing, the line is missing, or this
shell predates it — open a new one
before suspecting worse (chapter 16).
