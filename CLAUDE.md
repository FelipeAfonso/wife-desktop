# Repo rules for agents

## No PRs here: ask before merging to main

Override of the global worktree & branching discipline for this repo: don't
open PRs. Work on a branch or worktree as usual, push it, then report what
changed and ask Felipe for permission to merge to main. Merge only after he
says yes, and run `./export_current` on ulthar after merging when the
change touches anything the machine consumes (configs, `bin/`, systemd
units, `agents/`). The hotfix exception from the global rules still applies.

## Two lineages: CachyOS's preset and miskatonic's habits

The desktop is CachyOS's `cachyos-hypr-noctalia` preset (Hyprland Lua
config split under `hypr/config/`, Noctalia shell, uwsm, greetd), copied
from `/etc/skel` on 2026-10-23 and bent toward miskatonic's keybinds and
monitor layout. pacman updates `/etc/skel` but never a home directory, so
upstream fixes are merged by hand: `bin/skel-diff` shows them. Keep local
edits small and commented so that diff stays readable.

`agents/*-global.md`, `agents/models.md`, skills and hooks are copies of
personal-desktop's, not links. When fixing one of them, check whether the
fix belongs in personal-desktop too and say so.
