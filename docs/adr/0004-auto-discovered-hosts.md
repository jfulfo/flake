# Auto-discovered per-host configurations keyed by hostname

## Status

accepted

## Context

`flake.nix` hard-coded global `host`/`profile`/`username` vars and keyed
`nixosConfigurations` by *profile* (`amd`, `nvidia`, …). Every machine edited
those 3 lines locally, so the working tree was permanently dirty and every
downstream fork conflicted on `flake.nix` on every merge. The `--hostname`
passed to `nh` was actually the profile name, not the host.

## Decision

`flake.nix` enumerates `hosts/*` and produces one `nixosConfiguration` per
**hostname**. Each host's `variables.nix` carries its own `profile` and `user`
keys, which the flake reads at eval time to wire drivers and identity. Machines
build with `--hostname $(hostname)`.

## Consequences

- `flake.nix` is never edited per-machine; no more dirty tree.
- Adding device #26 is purely additive (drop in `hosts/<device>/`) → no merge
  conflict, ever.
- `host` / `profile` / `user` are disentangled: a host names its profile and
  user as data.
- Forks inherit upstream's host folders harmlessly and add their own alongside.
- **One-time breaking change**: the build command changes from
  `--hostname <profile>` to `--hostname <host>` (the `fr`/`fu` aliases change).
  Announced per ADR-0002.

## Considered alternatives

- **Explicit host-registry attrset in `flake.nix`**: rejected — a central file
  every fork edits reintroduces recurring merge conflicts.
- **Separate `meta.nix` per host**: rejected for an extra file per device;
  `profile`/`user` live in the host's `variables.nix` instead.
