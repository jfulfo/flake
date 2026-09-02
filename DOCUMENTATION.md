# documentation

this document largely serves as a means of helping charlotte remember important
details of the structure of this flake. however, it may serve as meaningful to
anyone wishing to draw inspiration from this flake, so it is being included
here.

## overview

this section provides a big-picture overview of the important files in this
flake and their purposes.

### hosts

`hosts/${hostname}/variables.nix` serves as the place to define most of the
important options. this includes, but is not limited to:

1. the user's git username and email,
2. hyprland monitor settings,
3. the default wallpaper,
4. font sizes,
5. the default editor and browser,
6. whether or not to install certain software. currently, the following
   variables are available for configuration:
   - `gaming`: toggles the inclusion of software like retroarch and steam
   - `texlive`: toggles whether to provide texlive-full. this in particular is
     provided because texlive is large, and its presence significantly impacts
     build times.
   - `silly`: toggles nonsense CLI software like cowsay and cmatrix

and more. `hosts/${hostname}/hardware.nix` is a direct copy of the file
`/etc/nixos/hardware-configuration.nix` generated when the user runs the
following command:

```sh
nixos-generate-config
```

currently, `hosts/${hostname}/default.nix` just imports `variables.nix`. if
`variables.nix` ever gets too bloated, it will be split up, so this structure
will be kept for the time being.

### modules

the folder for managing `nixpkgs` and `home-manager` dependencies. graphics
drivers are also in here. currently, both `modules/core` and `modules/home` have
a `default.nix` file which just imports all of the packages of interest.

## breaking changes and the changelog

this repo is upstream for several forks (see `docs/adr/0001`). there are no
version numbers or release tags. a downstream fork's "version coordinate" is
simply the commit it last merged from upstream. to find out what changed, and in
particular what needs manual action on a fork, read `CHANGELOG.md` forward from
that commit. entries marked `BREAKING CHANGE` require migration.

### for the maintainer

commits on this repo follow [conventional
commits](https://www.conventionalcommits.org/) (see `docs/adr/0002`). a
self-installing `commit-msg` hook enforces this. the workflow is:

1. `cd ~/.dotfiles`. direnv loads the flake's dev shell (run `direnv allow` once
   per clone), and the `commit-msg` hook is installed automatically.
2. write commits like `feat: ...`, `fix: ...`, `refactor!: ...`. a breaking
   change carries a `!` and/or a `BREAKING CHANGE: <what + how to migrate>`
   footer.
3. regenerate the changelog with `cog changelog > CHANGELOG.md`. cocogitto owns
   this file, so it should not be hand-edited, and forks should never regenerate
   it or they will conflict on every merge.
