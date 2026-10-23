# This machine: ulthar (Felipe's wife's desktop)

You are running on **ulthar**, a CachyOS (Arch) desktop that belongs to
Felipe's wife (user `jacque`). Hyprland on Wayland with the CachyOS
Noctalia preset, two 4K monitors (DP-1 Dell on the left is primary, DP-3 LG
on the right), an AMD RX 6950 XT (RDNA2, mesa/radv, Felipe's old card),
browsers, Steam, World of Warcraft. Keyboard is US layout with the
`alt-intl` variant; she types in Brazilian Portuguese and the locale is
pt_BR. She is not a power user and did not set any of this up; Felipe did,
and he is the one talking to you, usually from another machine over T3 Code
or ssh. Treat the box as hers: don't leave it in a state she has to
understand. If something is half-fixed, revert it and report.

## Environment

- Imperative Arch with tracked config: this machine's state lives in
  `~/code/wife-desktop` (GitHub: FelipeAfonso/wife-desktop). Sync is
  copy-based: edit the repo, `./export_current` applies it to the machine;
  `./import_current` pulls live state (plus pkglist/services dumps) back into
  the repo to be committed. Install software with pacman/paru normally; the
  next import records it.
- These very instructions are generated: `export_current` concatenates
  `agents/*.md` from that repo into `~/.claude/CLAUDE.md`,
  `~/.codex/AGENTS.md`, and `~/.config/opencode/AGENTS.md`. To change them,
  edit the repo files and re-export. The shared (non-machine) sections are
  copies of personal-desktop's `agents/*.md`; fix them there first.
- The desktop is CachyOS's `cachyos-hypr-noctalia` preset: Hyprland config
  split under `~/.config/hypr/config/*.lua` (binds, monitors, windowrules,
  variables...), Noctalia as bar/launcher/notifications/lock/theming
  (`~/.config/noctalia/config.toml`, `noctalia msg <cmd>`, `noctalia config
  validate`), apps launched through `uwsm app --`, login via greetd +
  noctalia-greeter. Compare with `/etc/skel/.config` (`skel-diff`) before
  inventing a fix; upstream changes land there, never in the home dir. The
  keybinds were changed to match miskatonic (Super+1-4 = workspace n, two per
  monitor, Super+G = gaming workspace, Super alone = launcher, Alt+F4
  closes). Both machines should run the same
  Hyprland version; if one was upgraded and the other wasn't, that is the
  first suspect.
- sudo asks for a password Felipe knows. Surface the sudo step so he can run
  or approve it; don't build automation that assumes unattended root.
- No secrets repo on this box. The `claude`, `codex`, `opencode`, and `gh`
  CLIs are authenticated with Felipe's accounts.
- T3 Code: the `t3code.service` user unit (port 3773) serves this machine to
  app.t3.codes. Never kill that unit, bind its port, or touch its unit files
  or `~/.t3`. Agent CLIs are bun globals in `~/.bun/bin` so T3's update
  button can update them without root; don't reinstall them via pacman.

## Gaming

Most bugs on this machine are WoW. It runs under Proton (Steam) or Wine
(Battle.net via Lutris); either way it is an Xwayland window. Hyprland's
window rules in `hypr/config/windowrules.lua` give it real fullscreen,
tearing (`immediate`), and idle inhibit; the WoW/Battle.net class regexes
there are unverified until the games are installed (`hyprctl clients`). gamescope is installed but not used; it fought WoW on the
previous setup (Bazzite/Plasma), so don't reintroduce it as a fix. MangoHud
(`Shift_L+F12` in game) is the overlay for FPS-drop investigations. WoW
addons come through WowUp (`wowup-cf-bin`).

## Network: the tailnet and the fleet

Everything rides Tailscale. The tailnet is `bass-pirarucu.ts.net` with
MagicDNS on, so every machine resolves by bare hostname (`ssh rlyeh` works,
no `~/.ssh/config` needed). Inbound to this box is Tailscale SSH: the ACL
allows `root@ulthar`, not `jacque@`; use `sudo -u jacque` for her files.

| host           | what it is                                | tailscale IP   | OS    |
| -------------- | ----------------------------------------- | -------------- | ----- |
| `ulthar`       | this box: Felipe's wife's gaming desktop  | 100.103.226.64 | linux |
| `miskatonic`   | Felipe's desktop and main seat            | 100.91.60.55   | linux |
| `rlyeh`        | always-on headless agent server (NixOS)   | 100.91.212.25  | linux |
| `yuggoth`      | Felipe's MacBook, online intermittently   | 100.120.128.70 | macOS |
| `necronomicon` | Felipe's iPhone (SSHes in via Termius)    | 100.114.0.102  | iOS   |

Full name for any of them is `<host>.bass-pirarucu.ts.net`. Port 3773
belongs to T3 Code; pick something else. Never enable `tailscale funnel`,
and never run `tailscale up/down/logout` or change ACLs unless Felipe asks
for exactly that.

## Operating the fleet

- Anything long-running or always-on belongs on rlyeh, not here. This
  machine reboots, updates, and is someone's game console.
- rlyeh is pure-flake NixOS (personal-server repo); never change it
  imperatively. miskatonic is Felipe's seat; look freely, edit nothing
  there unless the task calls for it, and say what you touched if you do.

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
