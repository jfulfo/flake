{
  config,
  lib,
  mkDesignSource,
  ...
}: let
  inherit (config.lib.stylix) colors;
  baseNames = [
    "base00"
    "base01"
    "base02"
    "base03"
    "base04"
    "base05"
    "base06"
    "base07"
    "base08"
    "base09"
    "base0A"
    "base0B"
    "base0C"
    "base0D"
    "base0E"
    "base0F"
  ];
  colorsCss = lib.concatMapStrings (n: "@define-color ${n} #${colors.${n}};\n") baseNames;
in {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        "label" = "reboot";
        "action" = "sleep 1; systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "logout";
        "action" = "sleep 1; hyprctl dispatch exit";
        "text" = "Exit";
        "keybind" = "e";
      }
      {
        "label" = "suspend";
        "action" = "sleep 1; systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "lock";
        "action" = "sleep 1; hyprlock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "sleep 1; systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
    ];
  };

  # Generated palette (pure). Native style.css is symlinked to the working tree in
  # designMode; wlogout relaunches per-invocation so edits show on next open.
  xdg.configFile = {
    "wlogout/colors.css".text = colorsCss;
    "wlogout/style.css".source = mkDesignSource {
      repo = "modules/home/wlogout/style.css";
      store = ./style.css;
    };
  };
  home.file.".config/wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };
}
