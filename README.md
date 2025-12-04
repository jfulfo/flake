# charlotte's dotfiles

> [!WARNING]
> don't use these dotfiles if you don't know what you're doing. they can brick
> your machine. charlotte is not responsible if you use them to brick your
> machine.

the content of these dotfiles started as a fork of
[ZaneyOS](https://gitlab.com/Zaney/zaneyos). however, much of the content has
been completely overhauled, including:

- a wholly different [stylix](https://github.com/danth/stylix) theme, using
  [catppuccin](https://catppuccin.com/),
- a totally different [waybar](https://github.com/Alexays/Waybar),
- a highly customized [nvf](https://github.com/NotAShelf/nvf) configuration,
- development environments powered by
  [658060/dev-templates](https://github.com/658060/dev-templates),

and more. also, some code (especially that of the waybar) is directly
taken/converted into nix from
[JaKooLit's dotfiles](https://github.com/JaKooLit/Hyprland-Dots), which is a
modified version of JaKooLit's catppuccin-mocha themed waybar. attributions are
in comments in every file where code was copied, so one may search this repo for
"JaKooLit" to find that code.

## how to use

this repo should be cloned into `~/.dotfiles`.

### building this flake

1. ensure NixOS is installed.
2. ensure that the optional settings `nix-command` and `flake` are enabled:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

3. edit `flake.nix`:
   - ensure the `profile` variable corresponds to the device's hardware. it
     should be set to one of the names of the folders in `~/.dotfiles/profiles`.
     for example, a laptop with an nvidia gpu should have `profile` set to
     `nvidia-laptop`.
   - Set the `hostname`.
4. ensure there is a folder `hosts/YOUR_HOSTNAME`. the folder `hosts/kamakiri`
   can serve as a template. ensure the file `hosts/YOUR_hostname/hardware.nix`
   is exactly the same as the file `hardware-configuration.nix` obtained when
   the command `nixos-generate-config` is run.
5. run the following commands:

```sh
nix shell nixpkgs#nh
nh os switch ~/.dotfiles --hostname YOUR_PROFILE
```

if this flake has already been built and is currently running on the machine,
run

```sh
fr
```

to rebuild after making changes. to update system packages, run

```sh
fu
```

instead.

### creating an iso image

to build an iso image out of this flake, run

```sh
nix build .#nixosConfigurations.iso.config.system.build.isoImage
```

the output will be stored in `./result/iso/`. to burn this to drive `/dev/sdX`,
run

```sh
sudo dd if=~/.dotfiles/result/iso/ISO_NAME.iso bs=16M of=/dev/sdX status=progress oflag=sync
```

replacing `ISO_NAME.iso` with the actual name of the file located there. be
warned, running the above command on the wrong drive will ruin a drive. use at
your own risk.
