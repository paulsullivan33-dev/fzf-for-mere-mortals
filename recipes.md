# Recipes

Small jobs, whole. Each is built from
parts the earlier chapters verified —
the feeders and filters of chapters 5
and 7, the quoting of chapter 10 — and
each states whether its choosing step
is the window (a person's eyes) or a
`--filter` (a script's certainty). The
safety habit of chapter 10 applies
throughout: anything that would act
destructively is written with `echo`
first in this chapter, and should stay
that way in yours until you have read
its output.

## Open the file you half-remember

The job behind half of this guide, as
a procedure:

```bash
find . -type f | fzf --preview 'cat {}' > /tmp/chosen
"${EDITOR:-vi}" "$(cat /tmp/chosen)"
```

Or let Ctrl-T (chapter 12) put the name
on the line and skip the file. The
preview earns its place here: two
reports, two years, and the contents
— not the names — settle which.

## Jump to a folder by description

Alt-C (chapter 12) is this recipe on a
key. By hand, when the integration is
not installed:

```bash
cd "$(find . -type d | fzf)"
```

The quotes are the recipe's real
ingredient: a folder named with spaces
must arrive at `cd` as one argument.

## Copy the chosen few, somewhere else

The multi-select job, with the reading
step left in:

```bash
find . -type f | fzf --multi --print0 |
  xargs -0 echo cp -t /path/to/destination
```

Read the printed commands. Remove
`echo`, run again, and the files move.
On the day a name with a newline shows
up, the `--print0`/`-0` pair is why
this still works (chapter 10).

## Find the line, then open the file there

Chapter 7's pipeline, completed by an
editor that accepts `+LINE`:

```bash
hit=$(grep -rin 'cinnamon' . | fzf --filter='sticks')
file=${hit%%:*}; rest=${hit#*:}; line=${rest%%:*}
"${EDITOR:-vi}" "+$line" "$file"
```

Splitting on the *first* colon for the
file and the *second* for the number
keeps text containing colons intact —
the trap chapter 7 named, handled the
way chapter 8 prescribed: capture,
test, quote. Run it in the practice
tree and your editor opens
`holiday-plan.txt` at its mulled-juice
line.

## Re-run an old command, slightly changed

Ctrl-R (chapter 6), then *edit before
Enter*: the recipe is a discipline,
not a command. The historical instance
is a draft; change the date, the file,
the one flag this occasion needs. The
command you run is the one on the line
now, read once with your own eyes —
chapter 1's rule on its home ground.

## See a process before you touch it

A feeder does not have to print files:

```bash
ps aux | fzf
```

The chosen line is printed and nothing
more — identification, not action. If
the job continues toward `kill`, it
continues with the number you have now
read twice, typed by you: fzf's part
of any such pipeline should end at
*showing you the line*, and this
guide's recipes keep it there on
purpose.

## A standing search for one tree

Some searches are daily. Give one a
name in your shell's startup:

```bash
alias garden='cd ~/garden && find . -type f | fzf'
```

—the feeder, the tree and the window,
one word long. When the daily search
changes shape often enough to deserve
options, it has become a script, and
chapter 8 is its home.
