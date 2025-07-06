{pkgs, ...}: let
  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    ${pkgs.swww}/bin/swww img "$1" &
    ${pkgs.libnotify}/bin/notify-send "Wallpaper Changed" "Set wallpaper to: $(basename "$1")" -i "$1" -t 3000
    ${pkgs.pyprland}/bin/pypr hide wallpaper_selector
  '';

  imv-wallpaper-selector = pkgs.writeShellScriptBin "imv-wallpaper-selector" ''
    exec ${pkgs.imv}/bin/imv -r "$HOME/Pictures/Wallpapers" \
      -c "bind x exec ${set-wallpaper}/bin/set-wallpaper \"\$imv_current_file\"" \
      -c "bind <Return> exec ${set-wallpaper}/bin/set-wallpaper \"\$imv_current_file\"; quit" \
      -w "Wallpaper Selector"
  '';
in {
  home.packages = with pkgs; [
    pyprland
    set-wallpaper
    imv-wallpaper-selector
  ];

  # relies on the existence of modules/home/scripts/wallsetter-visual.nix.

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
      "magnify",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "75% 60%"
    max_size = "1920px 100%"

    [scratchpads.volume]
    animation = "fromTop"
    command = "pavucontrol"
    class = "pavucontrol"
    lazy = true
    size = "40% 90%"

    [scratchpads.thunar]
    animation = "fromBottom"
    command = "thunar"
    class = "thunar"
    size = "75% 60%"

    [scratchpads.wallpaper_selector]
    animation = "fromTop"
    command = "${imv-wallpaper-selector}/bin/imv-wallpaper-selector"
    class = "imv"
    size = "75% 75%"
    lazy = true
    unfocus = "hide"
  '';
}
