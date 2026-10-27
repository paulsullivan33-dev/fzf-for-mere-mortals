# Installing fzf

fzf is a single small program — one
binary, no services, nothing to configure
before it runs. It is installed the ways
small programs are: from an operating
system's packages, from the project's own
installer, or by placing the released
binary on your path by hand. This guide's
lab used the third route, the project's
official release binary, because the build
machine's package manager was locked by
another process that day; the routes end
at the same `fzf` command, and this
chapter teaches all three, packages
first, because for most readers a package
is the one they will actually use.

## The package install

On Debian or Ubuntu:

```bash
sudo apt install fzf
```

On Fedora it is `sudo dnf install fzf`;
on Arch, `sudo pacman -S fzf`; on macOS
with Homebrew, `brew install fzf`. One
honest warning about packages: they age.
A distribution's fzf can be several
releases behind the project, and two
things in this guide are young — the
shell integration printed by
`fzf --bash` (chapter 12) needs version
0.48 or later, and the built-in directory
walker is younger still. If a chapter's
command is refused by a packaged fzf
with "unknown option", the version is
the first suspect (chapter 16), and the
installer below is the fix.

## The project's installer

The project ships its own install script
inside its source tree. It downloads the
right binary for your machine, puts it in
`~/.fzf`, and offers — it asks first — to
set up the shell integration of
chapter 12 and the fuzzy completion that
rides with it:

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

On Windows this same route works inside
Git Bash or WSL, which are the places a
Windows reader will be using a terminal
like this guide's anyway; fzf also runs
in PowerShell with the integration
reduced, and that is the project's own
documentation's territory, not this
chapter's.

## The release binary, by hand

What the lab did. The project's releases
page offers one archive per platform;
the lab took the Linux amd64 build of
**0.74.5**, unpacked it, and put the
single binary in a folder on its path:

```bash
tar xzf fzf-0.74.5-linux_amd64.tar.gz
mkdir -p ~/bin
mv fzf ~/bin/
fzf --version
```

Check: the lab's version printout
(transcript `fzf-lab/transcripts/t00-version.txt`)
reads:

```text
$ fzf --version
0.74.5 (c0a193e0)
```

The version matters when you read other
people's advice: fzf is actively
developed, options arrive, and a tip
written for version 0.30 may name the
shell-setup files that a current version
prints from the binary itself. Every
transcript in this guide is from
0.74.5, and the options the chapters rely
on were checked against this binary's own
`--help` before they were taught.

## What the install does not do

No folders are created in your home, no
background process starts, and nothing is
written anywhere until you choose to add
one line to your shell's startup file
(chapter 12) — and even that line is
yours to add or skip. Removing fzf is
removing the binary and that line. A
program this easy to leave is a program
that is easy to try: if chapter 4 does
not win you over, the uninstall is
thirty seconds.
