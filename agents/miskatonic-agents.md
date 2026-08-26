# This machine: miskatonic (Felipe's desktop)

You are running on **miskatonic**, Felipe's CachyOS (Arch) desktop and main
workstation: Hyprland on Wayland, a real display, browsers, audio. Unlike on
rlyeh, Felipe is usually sitting right here, so asking is cheap. But the
machine is not always on: it reboots, updates, and hosts games. Anything that
must survive the desktop going away belongs on rlyeh (see the fleet below).

## Environment

- Imperative Arch with tracked config: this machine's state lives in
  `~/code/personal/personal-desktop` (public GitHub repo). Sync is copy-based:
  edit the repo, `./export_current` applies it to the machine;
  `./import_current` pulls live state (plus pkglist/services dumps) back into
  the repo to be committed. Install software with pacman/paru normally; the
  next import records it.
- These very instructions are generated: `export_current` concatenates
  `agents/*.md` from that repo into `~/.claude/CLAUDE.md`,
  `~/.codex/AGENTS.md`, and `~/.config/opencode/AGENTS.md`. To change them,
  edit the repo files and re-export; edits to the generated files are lost on
  the next export. The shared (non-machine) sections are kept in sync by hand
  with `home/felipe/agents/*.md` in personal-server.
- sudo asks for Felipe's password. Don't build automation that assumes
  unattended root; surface the sudo step so he can run or approve it.
- Secrets: `secrets-pull` decrypts the private sops/age secrets repo into
  `~/.config/zsh/.secrets.env` (0600, gitignored), which zsh exports. The
  `claude`, `codex`, `opencode`, and `gh` CLIs are already authenticated.
- T3 Code runs here too: the desktop AppImage (`t3code` launcher) and the
  `t3code.service` user unit (port 3773) that serves this machine to
  app.t3.codes. Never kill that unit, bind its port, or touch its unit files
  or `~/.t3`. Agent CLIs are bun globals in `~/.bun/bin` so T3's update
  button can update them without root; don't reinstall them via pacman.

## Network: the tailnet and the fleet

Everything rides Tailscale. The tailnet is `bass-pirarucu.ts.net` with
MagicDNS on, so every machine resolves by bare hostname (`ssh rlyeh` works,
no `~/.ssh/config` needed).

| host           | what it is                                | tailscale IP   | OS    |
| -------------- | ----------------------------------------- | -------------- | ----- |
| `miskatonic`   | this box: Felipe's desktop and main seat  | 100.91.60.55   | linux |
| `rlyeh`        | always-on headless agent server (NixOS)   | 100.91.212.25  | linux |
| `yuggoth`      | Felipe's MacBook, online intermittently   | 100.120.128.70 | macOS |
| `necronomicon` | Felipe's iPhone (SSHes in via Termius)    | 100.114.0.102  | iOS   |

Full name for any of them is `<host>.bass-pirarucu.ts.net`.

Dev servers: Felipe also opens them from the phone or the MacBook, so prefer
binding `0.0.0.0` and handing over the tailnet URL
(`http://miskatonic.bass-pirarucu.ts.net:<port>`) alongside `localhost`.
Port 3773 belongs to T3 Code; pick something else. Never enable
`tailscale funnel`, and never run `tailscale up/down/logout` or change ACLs
unless Felipe asks for exactly that.

## Operating the fleet

- rlyeh is the workhorse: anything long-running, scheduled, or always-on
  (watchers, servers, bots, overnight jobs) belongs there, not on this
  desktop. `ssh rlyeh`, start it detached (`tmux new -d -s <name>` or
  `systemd-run --user --unit <name>`), and report the unit or session name
  and how to stop it.
- rlyeh is pure-flake NixOS, defined by the personal-server repo
  (`~/code/personal-server` on rlyeh, checked out here at
  `~/code/personal/personal-server`). Never change rlyeh imperatively: edit
  the flake, push, then
  `ssh rlyeh 'sudo nixos-rebuild switch --flake ~/code/personal-server#rlyeh'`
  (rlyeh has passwordless sudo). That repo takes no PRs: push a branch, then
  ask Felipe before merging to main.
- rlyeh's own `t3code.service` (port 3773) is its #1 service; same hands-off
  rule as the local one.
- yuggoth (config repo: personal-laptop) and necronomicon come and go; never
  depend on them being up. On any machine that isn't this one, look freely
  (compare configs, check whether something runs) but don't edit, install,
  or restart anything unless the task calls for it, and say what you touched
  if you do.

## Unslop enforcement hooks

Two hooks in `~/.claude/settings.json` back the global unslop rule. A
UserPromptSubmit hook injects the rule into context every turn, and a Stop
gate (`~/.claude/hooks/unslop-stop-gate.py`) blocks ending a turn with a
substantial reply until the unslop skill was invoked via the Skill tool. If
your reply gets bounced with an unslop message, invoke the skill and
rewrite; don't try to work around the hook. The scripts are repo-managed
(`agents/hooks/`, installed by `export_current`); the hooks block in
settings.json is set by hand because Claude Code writes to that file at
runtime.
