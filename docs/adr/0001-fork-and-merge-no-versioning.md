# Fork-and-merge consumption with no release versioning

## Status

accepted

## Context

This config is upstream for ~5 users across 25+ devices. Each user keeps a
GitHub fork, carries their own `hosts/*` (and, in practice, their own
`modules/*` edits), and merges from upstream `main` to update. We need a way to
track breaking changes for those downstream maintainers.

## Decision

Keep the single-`main`, fork-and-merge model. We deliberately do **not**:

- cut release branches or a branch-per-version,
- publish semver release tags,
- expose this repo as a flake input for downstream to `follows`.

The "version coordinate" a downstream user has is simply **the commit SHA they
last merged**. Breaking changes are read forward from that SHA (see ADR-0002).

## Consequences

- Maintaining a fork — including resolving merge conflicts caused by upstream
  changes — is the fork owner's responsibility. Upstream's only obligation is to
  **announce** breaking changes, not to prevent downstream conflicts.
- Because forks build directly on `modules/`, a "breaking change" includes
  structural changes (a module file moved/renamed/removed), not just changes to
  the documented `variables` contract.

## Considered alternatives

- **Release branches / semver tags**: rejected — branch/version inflation for a
  single-developer repo with no real "release" cadence; the last-merged SHA
  already serves as the coordinate.
- **Consume as a flake input**: rejected — downstream already edits `modules/`
  directly, so a clean input boundary doesn't match how the repo is actually
  used.
