# charlotte's dotfiles — Context

A NixOS desktop-config monorepo maintained by a single developer and consumed by
several other people who fork it. This glossary fixes the vocabulary for talking
about that upstream/downstream relationship and the configuration contract
between them.

## Language

**Upstream**:
This repository (`658060/.dotfiles`), `main` branch, as maintained by the sole
developer. The single source of truth everyone else tracks.

**Downstream fork**:
A separate GitHub fork owned by one of the other users, which merges from
upstream `main` periodically and carries that user's own machines and edits.
Maintaining a fork — including resolving merge conflicts — is the fork owner's
responsibility, not upstream's.
_Avoid_: client, consumer, subscriber.

**Consumption model**:
Fork + merge. Downstream forks merge upstream `main` into their fork. They do
**not** consume this repo as a flake input, and there are no release branches or
version tags.

**Version coordinate**:
The way a downstream user identifies "where they are" relative to upstream: the
**commit SHA they last merged**. There is no semver, no release tag. Breaking
changes are read forward from that SHA.
_Avoid_: version number, release, tag.

**Breaking change**:
An upstream change that, after a downstream fork merges it, requires the fork
owner to take manual action or their build/experience breaks. Because forks
build directly on `modules/`, this includes **structural** changes (a module
file moved/renamed/removed, flake outputs changed) as well as **contract**
changes (a host variable renamed/removed/retyped, a default or behavior
changed) — not merely behavior tweaks.
_Avoid_: regression, bug (those are unintended; a breaking change is deliberate).

**Contract surface**:
The set of things a downstream fork is expected to depend on and supply:
`hosts/<device>/variables.nix` (~21 keys) plus the machine-selection inputs.
Target state (ADR-0003) is a **typed submodule** schema with per-key defaults,
validation, and a deprecation path; only `gitUsername`, `gitEmail`, and
`extraMonitorSettings` are required.
_Avoid_: API, config (too broad).

**Deprecation alias**:
A `mkRenamedOptionModule`/`mkRemovedOptionModule` entry that keeps a
renamed/removed `variables` key working while printing an in-build warning that
names the migration. Kept until clearly unused; its eventual removal is itself a
`BREAKING CHANGE:` commit.

**Host**:
One physical/virtual machine, represented by a `hosts/<device>/` folder
(`variables.nix` + `hardware.nix`). Per-device data.
_Avoid_: machine, node, system (overloaded by NixOS).

**Profile**:
A hardware-class selection (`amd`, `nvidia`, `nvidia-laptop`, `intel`, `vm`,
`iso`) that wires up the right drivers. A host names its profile as data in its
own `variables.nix`; `flake.nix` reads it at eval time to import
`./profiles/<profile>`. Since ADR-0004 the `nixosConfigurations` are keyed by
host, not by profile.
_Avoid_: variant, flavor.

**User**:
One of the people who runs this config. Distinct from Host (one user has many
hosts). Since ADR-0004 a host names its `user` as data in its own
`variables.nix` (read by `flake.nix`), alongside `gitUsername`/`gitEmail`. No
global `username` in `flake.nix` anymore.

**Native UI file**:
A desktop-UI config authored in its own language (`.lua`, `.qml`, `.jsonc`,
`.css`, `.conf`) and installed verbatim by home-manager, rather than generated
from a Nix heredoc. Theme colors are injected via a small generated
`colors.{lua,json,qml}` from the stylix palette.
_Avoid_: config string, generated config.

**Design mode**:
A per-host `designMode` bool. When true, native UI files are installed via
`mkOutOfStoreSymlink` to the repo working tree so edits hot-reload with no
rebuild. Only the active design machine enables it; production hosts and all
forks stay pure and reproducible.

**Seam**:
The intended ownership boundary between upstream-owned files and fork-owned
files. The aspiration is "data-only downstream" (forks touch only their
`hosts/<device>/` data); the reality is "open downstream" (forks also edit
`modules/`). Upstream's obligation is to **announce** when the ground moves, not
to prevent downstream conflicts.
