# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is Koki Takahashi's personal dotfiles repository — configuration files for shells, editors, terminals, and
various tools across Linux, Windows, and (historically) macOS. There is no build, lint, or test suite; changes are
verified by sourcing/reloading the relevant tool (`source ~/.bashrc`, restarting the app, etc.), not by running
commands in this repo.

## Installation model

`install.sh` symlinks only a hardcoded subset of files/dirs (`.bash .config .vim .bashrc .bash_profile .editorconfig
.gitconfig .gvimrc .inputrc .tmux.conf .uncrustify.cfg .vimrc .Xmodmap .zshrc`) from the repo root into `$HOME`,
backing up any pre-existing real file to `~/dotfiles.backup` first. It is idempotent (skips files that are already
symlinks).

Everything else tracked in the repo (`AutoHotKey.ahk`, `ConEmu.xml`, `Putty.reg`, `karabiner.json`, `crkbd.json`,
`vscode/`, `.atom/`, `userscripts/`, `userstyles/`, clink config, `imedict.txt`, `romantable.txt`, etc.) is *not*
wired up by `install.sh` — it's config meant to be manually imported into or copied to the target app (Windows
AutoHotKey, ConEmu, PuTTY, Karabiner-Elements, a Corne (crkbd) QMK/VIA layout, VS Code, Atom, userscript/userstyle
managers like Tampermonkey/Stylus, or a Japanese IME) on whichever OS that tool runs on. When editing these, keep in
mind they are consumed outside of a shell/editor reload in this repo and may target Windows specifically (e.g.
`.bashrc.bat`, `Microsoft.PowerShell_profile.ps1`, clink, ConEmu, PuTTY).

Submodules (`git submodule update --init --recursive` after cloning, or use the `clone` alias below):
- `.vim/bundle/neobundle.vim` — Vim plugin manager
- `.config/base16-shell` — base16 shell theming, sourced from `.bashrc`
- `.bundle/git-fire` — symlinked to `bin/git-fire`
- `.tmux/plugins/tpm` — tmux plugin manager

## Shell config layout

- `.bashrc` is the main interactive Bash config: aliases, PATH setup, and conditional `if [ -d ... ]` blocks that
  activate tool integrations (rbenv, pyenv, nvm, asdf, cargo, Go, Docker Machine, etc.) only if that tool is
  installed. Follow this same guarded pattern when adding a new tool integration rather than assuming it's present.
- `.bashrc` sources every `*.sh`/`*.bash` file in `~/.bash/` at the end (`.bash/` holds git completion/prompt
  scripts) — drop machine-local or vendored shell snippets there instead of editing `.bashrc` directly.
- `.bash_profile` just sources `.bashrc`.
- `.zshrc` and `.config/fish/config.fish` are secondary shell configs (zsh, fish); aliases defined in `.bashrc` are
  duplicated by hand in fish as `balias`/functions since fish can't source bash syntax — update both when changing a
  shared alias.
- Lines appended by external installers (pipx, Antigravity CLI, etc.) appear at the bottom of `.bashrc`/`.bash_profile`/
  `.config/fish/config.fish` with `# Added by ...` / `# Created by ...` comments — leave these alone unless the user
  asks to clean them up.

## Git config

- `.gitconfig` sets `core.hooksPath = ~/.config/git/hooks`, i.e. **every git repo on this machine** uses the hooks in
  `.config/git/hooks/`, not just this repo. Each hook (`pre-commit`, `pre-push`, etc.) is a one-line wrapper sourcing
  `_local-hook-exec`, which looks for a same-named hook in the *current* repo's own `.git/hooks/` and sources it if
  present. This lets per-project local hooks keep working underneath the global `hooksPath` override — don't replace
  this indirection with direct hook logic.
- `.gitconfig` defines many aliases, including deliberate typo aliases (`chekcout`, `comit`, `commti`, `statu`,
  `stats`, ...) to tolerate mistyped commands, plus `clone = clone --recursive --recurse-submodules -j8` for
  submodule-aware cloning.
- `.config/git/ignore` is the global gitignore (referenced by users of this machine, not committed as part of the
  repo's own ignore rules).

## Commit message convention

Recent history uses `Category: Description` in imperative mood, where `Category` is the tool/area touched
(`Bash`, `Git`, `VSCode`, `tmux`, `crkbd`, `AutoHotKey`, `userscripts`, ...), e.g. `Bash: Add /usr/games to PATH`,
`Git: change push.default from upstream to simple`, `VSCode: add YAML snippet for HTML Ruby`. Follow this format for
new commits.
