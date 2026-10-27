# Previews

Choosing from names alone has a failure
mode everyone meets: two lines that look
the same, and the difference is *inside*
them. The preview is fzf's answer — a
pane beside the list showing the inside
of the highlighted line while you are
still deciding. This chapter's outcome:
you can give a list a preview that makes
the choice obvious, and you know the two
costs — the preview runs a command, and
it runs it constantly.

## The preview command

`--preview` takes a shell command.
Wherever the command contains the
placeholder `{}`, fzf substitutes the
highlighted line — quoted, so a name
with spaces arrives as one argument —
and shows the command's output in the
pane, refreshed at every movement of
the highlight:

```bash
find . -type f | fzf --preview 'cat {}'
```

For a tree of text files that one word
is most of the value: the highlighted
file's contents, live, while the query
narrows. Other lines want other insides:

```bash
grep -rin pattern . | fzf --preview 'cat {1}'   # needs a field split; see below
ls -la | fzf --preview 'echo {}'                # the line itself, enlarged
```

Keep the command honest and cheap: it
runs again for *every* line the
highlight crosses, so a preview that
starts a heavy program makes the whole
window feel broken — chapter 16 lists a
laggy preview as a first-class cause of
"fzf is slow". Read-only by habit, too:
the pane is a place for looking, and a
preview that writes or deletes is a
chapter-1 violation waiting for a
stray keystroke.

## Placeholders

`{}` is the one to learn first. The
family, from the project's manual:

| Placeholder | Stands for |
|---|---|
| `{}` | the highlighted line, quoted for the shell |
| `{q}` | the current query |
| `{+}` | the lines chosen so far (with `--multi`), each quoted |
| `{n}` | the line's number in the list, from 0 |
| `{+f}` | a file holding the chosen lines — for commands that read a list from a file |

With a field-aware list — chapter 7's
grep lines, `file:number:text` — the
numbered forms `{1}`, `{2}` pick out
single fields under the current
delimiter (`--delimiter :` makes the
split explicit), which is how a preview
shows the *file* named at the start of
a grep line rather than the whole line.

## The pane

`--preview-window` places and sizes the
pane: a side and a share of the screen
(`right:50%` is the default shape), or
`up`, `down`, `hidden` — and more, in
the manual. Two working habits:

- **Start hidden, toggle by key.** A
  binding such as
  `--bind 'ctrl-/:toggle-preview'` (with
  `:hidden` in the window options) keeps
  the list wide until a line genuinely
  needs its inside examined. The binding
  is taught here as a pattern from the
  project's examples; like all the
  window's keys, it is documented-only
  in this guide's ledger.
- **Match the pane to the content.**
  Long text wants `wrap`; wide tabular
  lines want the pane below, full width.
  These are comforts, not correctness —
  the choice does not change what fzf
  prints.

## What the lab could and could not verify

Honesty, in the open where this guide
keeps it. The preview pane is part of
the interactive window, which the lab's
sandbox cannot drive — so the pane's
appearance and behaviour above are
documented-only, from the project's
manual. What the lab *did* run
(transcript `fzf-lab/transcripts/t10-preview.txt`)
is the pair of facts a script author
needs: `--preview` in `--filter` mode
is accepted and ignored — filter output
is the match alone, no pane machinery
in the way — and the command a preview
would run for the lab's match, run by
hand, prints the recipe in full:

```text
$ find . -type f | sort | fzf --filter=pancakes --preview 'cat {}'
./documents/recipe-pancakes.txt
$ cat ./documents/recipe-pancakes.txt
Pancakes
200 g flour, 2 eggs, 300 ml milk.
…
```

That division — the command verified,
the pane described — is the same one
chapter 6 draws for Ctrl-R, and for the
same reason: this guide does not print
what it did not see.

Check: at a terminal, run the first
command of this chapter in the practice
tree and move the highlight; the pane
shows each file's first lines as you
pass. If the window feels sluggish,
your preview command is the price —
make it smaller before blaming fzf.
