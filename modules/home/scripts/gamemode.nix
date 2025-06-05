{
  pkgs,
  config,
  ...
}: let
  inherit (config.variables) defaultWallpaper;
in
  # this script is sourced from JaKooLit's dotfiles:
  # https://github.com/JaKooLit/Hyprland-Dots/blob/main/config/hypr/scripts/GameMode.sh
  pkgs.writeShellScriptBin "gamemode" ''
    HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
    if [ "$HYPRGAMEMODE" = 1 ] ; then
        hyprctl --batch "\
            keyword animations:enabled 0;\
            keyword decoration:shadow:enabled 0;\
            keyword decoration:blur:enabled 0;\
            keyword general:gaps_in 0;\
            keyword general:gaps_out 0;\
            keyword general:border_size 0;\
            keyword decoration:rounding 0"

      hyprctl keyword "windowrule opacity 1 override 1 override 1 override, ^(.*)$"
        # swww kill
        pkill waybar
        notify-send "Gamemode: enabled"
        exit
    else
      # swww-daemon --format xrgb && swww img "$HOME/pictures/wallpapers/${defaultWallpaper}" &
      sleep 0.5
      hyprctl --batch "\
          keyword animations:enabled 1;\
          keyword decoration:shadow:enabled 1;\
          keyword decoration:blur:enabled 1;\
          keyword general:gaps_in 6;\
          keyword general:gaps_out 8;\
          keyword general:border_size 2;\
          keyword decoration:rounding 10"
        waybar &
        notify-send "Gamemode: disabled"
        exit
    fi
    hyprctl reload
  ''
