{
  pkgs,
  username,
  host,
  ...
}: {
  home.packages = [
    (import ./emopicker9000.nix {inherit pkgs;})
    (import ./gamemode.nix {inherit pkgs host;})
    (import ./keybinds.nix {inherit pkgs;})
    (import ./nvidia-offload.nix {inherit pkgs;})
    (import ./rofi-launcher.nix {inherit pkgs;})
    (import ./screenshootin.nix {inherit pkgs;})
    (import ./squirtle.nix {inherit pkgs;})
    (import ./task-waybar.nix {inherit pkgs;})
    (import ./wallsetter.nix {
      inherit pkgs username;
    })
    (import ./web-search.nix {inherit pkgs;})
  ];
}
