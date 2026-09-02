{
  pkgs,
  config,
  lib,
  mkDesignSource,
  ...
}: let
  inherit
    (config.variables)
    accent0
    accent1
    clock24h
    ;
  inherit (config.lib.stylix) colors;

  # The Nix-derived palette consumed by style.css via `@import "colors.css"`.
  # Hand-designed rules stay in the native, hot-reloadable style.css; only the
  # color definitions are generated here (ADR-0005).
  colorsCss = ''
    @define-color base   #${colors.base00};
    @define-color mantle #${colors.base01};
    @define-color crust  #11111b;

    @define-color text     #${colors.base05};
    @define-color subtext0 #a6adc8;
    @define-color subtext1 #bac2de;

    @define-color surface0 #${colors.base02};
    @define-color surface1 #${colors.base03};
    @define-color surface2 #${colors.base04};

    @define-color overlay0 #6c7086;
    @define-color overlay1 #7f849c;
    @define-color overlay2 #9399b2;

    @define-color blue      #${colors.base0D};
    @define-color lavender  #${colors.base07};
    @define-color sapphire  #74c7ec;
    @define-color sky       #89dceb;
    @define-color teal      #${colors.base0C};
    @define-color green     #${colors.base0B};
    @define-color yellow    #${colors.base0A};
    @define-color peach     #${colors.base09};
    @define-color maroon    #eba0ac;
    @define-color red       #${colors.base08};
    @define-color mauve     #${colors.base0E};
    @define-color pink      #f5c2e7;
    @define-color flamingo  #${colors.base0F};
    @define-color rosewater #${colors.base06};

    @define-color accent0 #${accent0};
    @define-color accent1 #${accent1};
  '';
in {
  # this waybar is compatible with all catppuccin palettes.
  # aesthetic compatibility with other palettes may vary.
  # to change the accent colors used, modify `accent0` and `accent1`
  # defined in modules/core/palettes.nix.
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        exclusive = true;
        passthrough = false;
        spacing = 4;
        fixed-center = true;
        #modules-left = [
        #  "custom/separator#blank"
        #  # for this one to come back, it needs to be a more consistent size
        #  #"hyprland/window"
        #  #"custom/separator#dot-line"
        #  "tray"
        #  "custom/separator#blank"
        #];
        modules-center = [
          "custom/separator#blank"
          "cava"
          "custom/separator#dot-line"
          "clock"
          "custom/separator#line"
          "hyprland/workspaces"
          "idle_inhibitor"
          "custom/separator#blank"
        ];
        modules-right = [
          "custom/separator#blank"
          "custom/swaync"
          "custom/separator#dot-line"
          "tray"
          "custom/separator#dot-line"
          "battery"
          "custom/power"
          "custom/separator#blank"
        ];

        # kanji numbers for workspaces
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
          disable-scroll = true;
          show-special = false;

          # TODO: figure out how to force workspaces to certain monitors
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "tray" = {
          spacing = 12;
        };

        "idle_inhibitor" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
        };

        "clock" = {
          format =
            if clock24h
            then ''  {:L%H:%M}''
            else ''  {:L%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };

        "cava" = {
          framerate = 30;
          autosens = 1;
          # sensitivity = 1;
          bars = 14;
          method = "pulse";
          source = "auto";
          stereo = true;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          lower_cutoff_freq = 75;
          higher_cutoff_freq = 10000;
          noise_reduction = 0.8;
          input_delay = 2;
          format-icons = [
            "<span foreground='#${accent0}'>▁</span>"
            "<span foreground='#${accent0}'>▂</span>"
            "<span foreground='#${accent0}'>▃</span>"
            "<span foreground='#${accent0}'>▄</span>"
            "<span foreground='#${accent0}'>▅</span>"
            "<span foreground='#${accent1}'>▆</span>"
            "<span foreground='#${accent1}'>▇</span>"
            "<span foreground='#${accent1}'>█</span>"
          ];
          actions = {
            on-click-right = "mode";
          };
        };

        # custom modules
        # most of these are stolen from JaKooLit.
        "custom/swaync" = {
          tooltip = false;
          format = "{icon} {text}";
          format-icons = {
            notification = " ";
            none = " ";
            dnd-notification = " ";
            dnd-none = " ";
            inhibited-notification = " ";
            inhibited-none = " ";
            dnd-inhibited-notification = " ";
            dnd-inhibited-none = " ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/separator#dot-line" = {
          format = "";
          interval = "once";
          tooltip = false;
        };
        "custom/separator#line" = {
          format = "|";
          interval = "once";
          tooltip = false;
        };
        "custom/separator#blank" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "custom/power" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };
      }
    ];
  };

  # Generated palette (pure, store-only). Native style.css is symlinked to the
  # working tree in designMode for live SIGUSR2 reload, else the in-store copy.
  xdg.configFile = {
    "waybar/colors.css".text = colorsCss;
    "waybar/style.css".source = mkDesignSource {
      repo = "modules/home/waybar/style.css";
      store = ./style.css;
    };
  };
}
