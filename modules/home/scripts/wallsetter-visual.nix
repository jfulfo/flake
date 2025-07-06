{pkgs, ...}:
pkgs.writeShellScriptBin "wallsetter-visual" ''
  WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

  # Check if directory exists
  if [ ! -d "$WALLPAPER_DIR" ]; then
    ${pkgs.libnotify}/bin/notify-send "Wallpaper Selector" "Directory $WALLPAPER_DIR does not exist!" -u critical
    exit 1
  fi

  # Toggle the wallpaper selector scratchpad
  ${pkgs.pyprland}/bin/pypr toggle wallpaper_selector
''
