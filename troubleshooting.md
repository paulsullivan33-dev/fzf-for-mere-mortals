# Troubleshooting

Symptom first, cause second, in the
order the lab and the documentation
suggest you check them.

## The match that should exist, doesn't

*You can see the file in the tree.
fzf insists otherwise.*

1. **The feeder never printed it.**
   Run the feeder alone and read the
   list. The usual shapes: the feeder
   skipped it (a searcher's case —
   chapter 7's trap, transcript t90 —
   a `find` pattern, a folder you are
   not standing where you think).
   More searches are lost here than in
   all other entries combined.
2. **Smart case.** A capital letter in
   your query made it case-sensitive
   (chapter 2). The lab's `Annual`
   matched nothing in a tree full of
   `annual` and exited 1 (transcript
   t02). Retype in lower case, or set
   `--ignore-case` if capitals are the
   habit.
3. **The anchor sees the whole line.**
   `^annual` matches no path, because
   lines start with their folder
   (transcript t02). Anchor what the
   line actually starts with — or
   scope the match to the name with
   `--nth` (chapter 5).
4. **The query's second word fits
   nothing.** *And* is strict: every
   piece must fit the same line. Drop
   words until it matches, then add
   back the one that helps.

## The window opens empty

*The feeder works alone; fzf shows
nothing.*

1. **The pipe is not the feeder you
   think.** A filter earlier in the
   pipeline (a `grep` that matched
   nothing) starved the list. Test the
   pipeline in stages.
2. **You wanted the default list.**
   With input piped — even from an
   empty pipe — there is no default:
   piped input *is* the list. For
   fzf's own listing, run it bare at a
   terminal, or set
   `FZF_DEFAULT_COMMAND` (chapter 11).
3. **A query was left standing.**
   `--query=` in your
   `FZF_DEFAULT_OPTS`, or a widget's
   `*_OPTS`, pre-typed a filter that
   fits nothing. The window is honest;
   the standing query is the surprise.

## The script hangs

*A pipeline that worked by hand waits
forever in a script.*

1. **The window is open in the dark.**
   Without `--filter`, fzf at any hint
   of a terminal opens its window —
   on a terminal device the script may
   still own. Scripts use `--filter`
   (chapter 8), always.
2. **fzf is reading the script's own
   input.** With no pipe of its own,
   in a script, fzf's list *is* the
   script's standard input — and it
   will consume the very lines a later
   `read` was waiting for. Give fzf
   its list explicitly, or `< /dev/null`
   where it should find none.

## The wrong line got acted on

*The script chose a file — a real one,
not the meant one.*

1. **Score order.** The first output
   line is the *best* match, not the
   first in the list (chapter 4's
   `2024` put `budget` above `annual`).
   If the script needs input order,
   say `--no-sort`. If it needs the
   best match, tighten the query until
   the best is the only plausible.
2. **The printed query came along.**
   With `--print-query`, output line
   one is the question (chapter 8).
   A script that treats all output as
   choices will one day act on the
   query text as a file name.
3. **`set -e` met a healthy 1.**
   No match exits 1 (transcript t06) —
   a result, handled on purpose in
   chapter 8's script, a silent death
   in a script that forgot.

## The name arrived in pieces

*An action split one chosen name into
two, or dropped its spaces.*

Unquoted expansion, somewhere after
fzf. The choice was one line; `$choice`
unquoted made it several arguments.
Quote it (chapter 8); for names with
stranger characters, move the whole
pipeline to chapter 10's NUL form
(`--print0`, `read -d ''`, `xargs -0`).

## The window feels slow

1. **The preview is the price.** It
   runs at every highlight movement
   (chapter 9). Make the command
   cheaper, bound its work (`head`),
   or start hidden and toggle.
2. **The list is enormous and the
   feeder rebuilds it per search.**
   Narrow in the feeder first
   (chapter 15); fzf cannot rank
   faster than its list arrives.

## Ctrl-R (or Ctrl-T, Alt-C) does nothing

1. **The integration is not loaded in
   this shell.** It loads from the
   startup file; a shell opened before
   you added the line (chapter 12)
   does not have it. Open a new shell,
   or evaluate the line by hand, and
   test with transcript t09's
   `type -t` check.
2. **The version's plumbing differs.**
   Packaged fzf older than 0.48 has no
   `--bash` to evaluate; it wants its
   `key-bindings` file sourced instead
   (chapter 12).
3. **Another program owns the key.**
   Terminals reserve some chords (a
   menu on Alt-C is the classic);
   the widget is installed and the
   key never reaches the shell. The
   terminal's settings, or Esc-then-C,
   are the fixes.
4. **Ctrl-R opens, but the past is
   tiny.** The widget searches the
   history the shell *keeps*. Small
   history settings are a shell matter
   (`HISTSIZE` and friends), not an
   fzf one (chapter 6).
