{
  pkgs,
  config,
  host,
  ...
}: let
  cava_mviz = ./cava_mviz.sh;
  inherit (import ../../../hosts/${host}/variables.nix) clock24h;
in {
  # Configure & Theme Waybar
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
          "pulseaudio"
          "custom/separator#blank"
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
          format = "{icon} {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-alt-click = "click";
          format-full = "{icon} Full";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂎"
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
          format-time = "{H}h {M}min";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-bluetooth-muted = " {icon}";
          format-muted = "󰸈";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          tooltip = true;
          tooltip-format = "{icon} {desc} | {volume}%";
        };

        "clock" = {
          format =
            if clock24h
            then ''  {:L%H:%M}''
            else ''  {:L%I:%M %p}'';
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
            "<span foreground='#${config.lib.stylix.colors.base0D}'>▁</span>"
            "<span foreground='#${config.lib.stylix.colors.base0D}'>▂</span>"
            "<span foreground='#${config.lib.stylix.colors.base0D}'>▃</span>"
            "<span foreground='#${config.lib.stylix.colors.base0D}'>▄</span>"
            "<span foreground='#${config.lib.stylix.colors.base0D}'>▅</span>"
            "<span foreground='#${config.lib.stylix.colors.base0E}'>▆</span>"
            "<span foreground='#${config.lib.stylix.colors.base0E}'>▇</span>"
            "<span foreground='#${config.lib.stylix.colors.base0E}'>█</span>"
          ];
          actions = {
            on-click-right = "mode";
          };
        };

        # custom modules
        # most of these are stolen from JaKooLit.

        # does not work.
        "custom/cava_mviz" = {
          exec = "${cava_mviz}";
          format = "{}";
        };
        "custom/swaync" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/separator#dot-line" = {
          format = "";
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
    style = builtins.readFile ./style.css;
  };
}
