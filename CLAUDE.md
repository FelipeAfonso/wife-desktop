# Repo rules for agents

## No PRs here: ask before merging to main

Override of the global worktree & branching discipline for this repo: don't
open PRs. Work on a branch or worktree as usual, push it, then report what
changed and ask Felipe for permission to merge to main. Merge only after he
says yes, and run `./export_current` after merging when the change touches
anything the machine consumes (configs, `bin/`, systemd units, `agents/`).
The hotfix exception from the global rules still applies.
