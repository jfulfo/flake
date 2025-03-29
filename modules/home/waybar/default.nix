{
  pkgs,
  config,
  lib,
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
    # style = builtins.readFile ./style.css;
    style = lib.concatStrings [
      ''
        * {
          font-family: "Montserrat";
          font-weight: 600;
          min-height: 0;
          /* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
          font-size: 97%;
          font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        }

        @define-color base   #${config.lib.stylix.colors.base00};
        @define-color mantle #${config.lib.stylix.colors.base01};
        @define-color crust  #11111b;

        @define-color text     #${config.lib.stylix.colors.base05};
        @define-color subtext0 #a6adc8;
        @define-color subtext1 #bac2de;

        @define-color surface0 #${config.lib.stylix.colors.base02};
        @define-color surface1 #${config.lib.stylix.colors.base03};
        @define-color surface2 #${config.lib.stylix.colors.base04};

        @define-color overlay0 #6c7086;
        @define-color overlay1 #7f849c;
        @define-color overlay2 #9399b2;

        @define-color blue      #${config.lib.stylix.colors.base0D};
        @define-color lavender  #${config.lib.stylix.colors.base07};
        @define-color sapphire  #74c7ec;
        @define-color sky       #89dceb;
        @define-color teal      #${config.lib.stylix.colors.base0C};
        @define-color green     #${config.lib.stylix.colors.base0B};
        @define-color yellow    #${config.lib.stylix.colors.base0A};
        @define-color peach     #${config.lib.stylix.colors.base09};
        @define-color maroon    #eba0ac;
        @define-color red       #${config.lib.stylix.colors.base08};
        @define-color mauve     #${config.lib.stylix.colors.base0E};
        @define-color pink      #f5c2e7;
        @define-color flamingo  #${config.lib.stylix.colors.base0F};
        @define-color rosewater #${config.lib.stylix.colors.base06};

        window#waybar {
          	transition-property: background-color;
          	transition-duration: 0.5s;
          	background: transparent;
          	border-radius: 10px;
        }

        window#waybar.hidden {
          	opacity: 0.2;
        }

        window#waybar.empty,
        window#waybar.empty #window {
            background-color: transparent;
            padding: 0px;
            border: 0px;
        }

        #taskbar button,
        #workspaces button {
        	color: @overlay1;
          box-shadow: none;
        	text-shadow: none;
          padding: 0px;
          border-radius: 9px;
          padding-left: 4px;
          padding-right: 4px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #taskbar button:hover,
        #workspaces button:hover {
          border-radius: 10px;
          color: @peach;
          background-color: @surface0;
          padding-left: 2px;
          padding-right: 2px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #workspaces button.persistent {
        	color: @surface1;
        	border-radius: 10px;
        }

        #taskbar button.active,
        #workspaces button.active {
        	color: @mauve;
          border-radius: 10px;
          padding-left: 8px;
          padding-right: 8px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #workspaces button.urgent {
        	color: @red;
         	border-radius: 0px;
        }

        .modules-center, .modules-right {
          background: @base;
          border: 0.5px solid @overlay0;
        	padding-top: 2px;
        	padding-bottom: 2px;
        	padding-right: 4px;
        	padding-left: 4px;
        	border-radius: 10px;
        }

        .modules-right {
          border: 1px solid @mauve;
        }

        #backlight,
        #backlight-slider,
        #battery,
        #bluetooth,
        #clock,
        #cpu,
        #disk,
        #keyboard-state,
        #memory,
        #mode,
        #mpris,
        #network,
        #power-profiles-daemon,
        #pulseaudio,
        #pulseaudio-slider,
        #taskbar button,
        #taskbar,
        #temperature,
        #tray,
        #window,
        #wireplumber,
        #workspaces,
        #custom-backlight,
        #custom-browser,
        #custom-cava_mviz,
        #custom-cycle_wall,
        #custom-dot_update,
        #custom-file_manager,
        #custom-keybinds,
        #custom-keyboard,
        #custom-light_dark,
        #custom-lock,
        #custom-hint,
        #custom-hypridle,
        #custom-menu,
        #custom-playerctl,
        #custom-power_vertical,
        #custom-power,
        #custom-quit,
        #custom-reboot,
        #custom-settings,
        #custom-spotify,
        #custom-swaync,
        #custom-tty,
        #custom-updater,
        #custom-weather,
        #custom-weather.clearNight,
        #custom-weather.cloudyFoggyDay,
        #custom-weather.cloudyFoggyNight,
        #custom-weather.default,
        #custom-weather.rainyDay,
        #custom-weather.rainyNight,
        #custom-weather.severe,
        #custom-weather.showyIcyDay,
        #custom-weather.snowyIcyNight,
        #custom-weather.sunnyDay {
        	padding-top: 4px;
        	padding-bottom: 4px;
        	padding-right: 6px;
        	padding-left: 6px;
        }

        #idle_inhibitor {
          color: @text;
          padding-left: 4px;
          padding-right: 4px;
        }
        #idle_inhibitor.activated {
          color: @green;
        }
        #custom-hypridle.notactive,

        #bluetooth,
        #backlight {
          color: @blue;
        }

        #battery {
          color: @green;
        }

        @keyframes blink {
          to {
            color: @surface0;
          }
        }

        #battery.critical:not(.charging) {
          background-color: @red;
          color: @text;
        	animation-name: blink;
        	animation-duration: 3.0s;
        	animation-timing-function: steps(12);
        	animation-iteration-count: infinite;
        	animation-direction: alternate;
          box-shadow: inset 0 -3px transparent;
        }

        #clock {
          color: @yellow;
        }

        #cpu {
          color: @green;
        }

        #custom-keyboard,
        #memory {
          color: @sky;
        }

        #disk {
          color: @sapphire;
        }

        #temperature {
          color: @teal;
        }

        #temperature.critical {
          background-color: @red;
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }
        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
        }

        #keyboard-state {
          color: @flamingo;
        }

        #custom-cava_mviz {
        	color: @pink;
        }

        #custom-menu {
          color: @rosewater;
        }

        #custom-power {
          color: @red;
        }

        #custom-updater {
          color: @red;
        }

        #custom-light_dark {
          color: @blue;
        }

        #custom-weather {
          color: @lavender;
        }

        #custom-lock {
          color: @maroon;
        }

        #pulseaudio {
          color: @sapphire;
        }

        #pulseaudio.bluetooth {
          color: @pink;
        }
        #pulseaudio.muted {
          color: @red;
        }

        #window {
          color: @mauve;
        }

        #mpris {
          color:@lavender;
        }

        #network {
          color: @teal;
        }
        #network.disconnected,
        #network.disabled {
          background-color: @surface0;
          color: @text;
        }

        #backlight-slider slider,
        #pulseaudio-slider slider {
        	min-width: 0px;
        	min-height: 0px;
        	opacity: 0;
        	background-image: none;
        	border: none;
        	box-shadow: none;
        }

        #backlight-slider trough,
        #pulseaudio-slider trough {
        	min-width: 80px;
        	min-height: 5px;
        	border-radius: 5px;
        }

        #backlight-slider highlight,
        #pulseaudio-slider highlight {
        	min-height: 10px;
        	border-radius: 5px;
        }
      ''
    ];
  };
}
