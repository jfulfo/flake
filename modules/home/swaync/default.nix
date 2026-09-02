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
  # base16 palette as GTK @define-color, generated from stylix and @import-ed by
  # the native style.css (ADR-0005).
  colorsCss = lib.concatMapStrings (n: "@define-color ${n} #${colors.${n}};\n") baseNames;
in {
  services.swaync = {
    enable = true;
    # Force off HM's + stylix's managed style.css so ours (below) owns
    # swaync/style.css; swaync auto-loads style.css from its config dir (no -s flag).
    style = lib.mkForce null;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = false;
      control-center-width = 500;
      control-center-height = 1025;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      widget-config = {
        title = {
          text = "Notification Center";
          clear-all-button = true;
          button-text = "󰆴 Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 1;
          text = "Notification Center";
        };
        mpris = {
          image-size = 96;
          image-radius = 7;
        };
        volume = {
          label = "󰕾";
        };
        backlight = {
          label = "󰃟";
        };
      };
      widgets = [
        "title"
        "mpris"
        "volume"
        "backlight"
        "dnd"
        "notifications"
      ];
    };
  };

  # Generated palette (pure). Native style.css is symlinked to the working tree in
  # designMode for live `swaync-client -rs` reload, else the in-store copy.
  xdg.configFile = {
    "swaync/colors.css".text = colorsCss;
    "swaync/style.css".source = mkDesignSource {
      repo = "modules/home/swaync/style.css";
      store = ./style.css;
    };
  };
}
