# Repo rules for agents

## No PRs here: ask before merging to main

Override of the global worktree & branching discipline for this repo: don't
open PRs. Work on a branch or worktree as usual, push it, then report what
changed and ask Felipe for permission to merge to main. Merge only after he
says yes, and run `./export_current` on kingsport after merging when the
change touches anything the machine consumes (configs, `bin/`, systemd
units, `agents/`). The hotfix exception from the global rules still applies.

## Two repos, one lineage

This repo was forked from personal-desktop (miskatonic) on 2026-09-08 and
trimmed to a browser-and-WoW box. Shared pieces (wallust templates, waybar
style, rofi, dunst, `agents/*-global.md`, `agents/models.md`, skills,
hooks) are copies, not links. When fixing one of them, check whether the
fix belongs in personal-desktop too and say so.
