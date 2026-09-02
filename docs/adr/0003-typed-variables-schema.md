# Typed `variables` schema instead of free attrs

## Status

accepted

## Context

`hosts/<device>/variables.nix` is the documented contract surface every
downstream fork depends on (~21 keys). It was declared as
`options.variables = lib.mkOption { type = lib.types.attrs; }` — a free-form
attrset with no schema, defaults, validation, or deprecation path. A renamed or
removed key broke downstream forks with a cryptic eval error and no migration
hint, which is the core breaking-change pain (see ADR-0002).

## Decision

Promote `variables` to a **typed submodule**:

- The schema lives centrally in `modules/core/variables.nix` as
  `options.variables = lib.types.submodule { options = { ... }; }`, one
  `mkOption` (with `description` + `default`) per key. `hosts/<device>/
  variables.nix` stays a plain **data** file checked against the schema.
- Home-manager continues to receive the already-resolved `config.variables` as a
  passthrough (`systemVariables`), so the schema is declared once, NixOS-side.
- **Default-heavy** policy: only `gitUsername`, `gitEmail`,
  `extraMonitorSettings` are required (plus `intelID`/`nvidiaID`, default `null`,
  asserted by the `nvidia-laptop` profile). Everything else defaults to today's
  values. The minimal new-device file is ~3 keys + `hardware.nix`.
- Renames and removals ship through `lib.mkRenamedOptionModule` /
  `lib.mkRemovedOptionModule`, so a downstream build keeps working and prints an
  in-build warning naming the migration — complementing, not duplicating, the
  CHANGELOG.

## Consequences

- Breaking changes to the contract become **warnings in the downstream's own
  `nixos-rebuild` output**, not silent breakage — the largest reduction in
  downstream pain.
- Every new variable must now be *declared* in the schema, not merely used.
- Deprecation aliases are kept until clearly unused (there are no releases to
  anchor removal to); their eventual removal is itself a `BREAKING CHANGE:`
  commit.
