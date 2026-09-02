# Native UI files with an opt-in design mode for live iteration

## Status

accepted

## Context

The desktop UI (hyprland, waybar, …) is authored as Nix that *generates* the
target language — e.g. `hyprland/config.nix` is ~389 lines of Lua inside a Nix
heredoc with `${interpolation}`. This means no LSP/highlighting for the embedded
language, Nix string-escaping friction, and — worst for design — a full
`nixos-rebuild` between every visual tweak and seeing it. The sole developer
wants a fast visual-iteration loop.

## Decision

- **Author UI configs as native files** (`.lua`, `.qml`, `.jsonc`, `.css`,
  `.conf`) installed verbatim by home-manager (`source = ./file`).
- **`designMode`** (a per-host bool variable): when true, the relevant configs
  are installed via `config.lib.file.mkOutOfStoreSymlink` pointing at the repo
  working tree (resolved via a `dotfilesPath` variable, default
  `/home/<user>/.dotfiles`), so the live config *is* the working copy. Combined
  with each tool's live reload (`hyprctl reload`, waybar `SIGUSR2`, quickshell's
  QML watcher), edits appear with **no rebuild**.
- **Theme stays declarative**: a small `colors.{lua,json,qml}` is generated from
  `config.lib.stylix.colors` and imported by the native files. Bulk stays native
  and hot-reloadable; palette stays Nix-driven.
- **Scope/order**: quickshell (greenfield native QML) + hyprland first, waybar
  next; rofi/wlogout/hyprlock converted only when actively designed.

## Consequences

- Only the active design machine sets `designMode = true`. Production hosts and
  **all downstream forks stay pure, declarative, and reproducible** — the
  out-of-store symlink is never on their critical path.
- `designMode` deliberately trades reproducibility for iteration speed on one
  machine; the "commit" step is simply that the edited native file is already in
  the repo, ready to be committed.
