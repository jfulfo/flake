# Quickshell replaces waybar as the primary status bar

## Status

proposed

## Context

waybar works and is stable, but it is JSONC + CSS with a fixed module set and no
real programmability. Quickshell (QML) is already an input, installed, and
design-mode-wired (ADR-0005), yet it has only ever run a 61-line stub while
waybar stays the real bar. The design-mode loop was built precisely to iterate
on a bar like this, and it is proven working on laptop2 (symlinks resolve to the
working tree, `qs` loads clean).

## Decision

Build quickshell into the primary bar and retire waybar. Constraints from the
grilling session:

- **Full parity before cutover.** Every waybar module ports first
  (workspaces, window title, clock, battery, tray, volume/pulse, cava, swaync
  toggle, power menu), including cava via a `cava`-subprocess-to-QML bridge.
  Quickshell does not autostart and waybar is not dropped until parity lands, so
  there is no half-bar period.
- **Caelestia-inspired redesign**, not a waybar pixel-copy. Crib widget patterns
  from mature quickshell configs (caelestia-dots/shell, end-4/dots-hyprland)
  rather than inventing from scratch, adapted to the stylix palette.
- **Colors stay Nix-generated.** `Theme.qml` from `config.lib.stylix.colors`
  stays the single source of palette; the QML widgets stay native and
  hot-reloadable under design mode.
- QML is authored modular (per-widget files under `modules/home/quickshell/`),
  not one monolith.

## Consequences

- **Breaking change** for forks once the cutover commits: waybar is gone, so any
  fork relying on it must either pin the old bar or follow. Announce per
  ADR-0002 (`feat!:` + `BREAKING CHANGE:` footer).
- cava is the highest-risk module (no native quickshell equivalent); if the
  subprocess bridge proves not worth it, it can be dropped without blocking the
  rest.
- Trades waybar's stability for programmability and a faster in-repo design loop.

## Considered alternatives

- **Keep waybar, park quickshell** — rejected: leaves the ADR-0005 investment
  unused and the bar unprogrammable.
- **MVP subset, autostart alongside waybar, iterate live** — rejected in favour
  of one clean parity cutover with no dual-bar period.
