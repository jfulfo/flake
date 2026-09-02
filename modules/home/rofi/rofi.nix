{
  pkgs,
  config,
  mkDesignSource,
  ...
}: let
  inherit (config.lib.stylix) colors;

  # rofi rasi palette, generated from stylix. The native theme.rasi imports this
  # via an absolute `~` path (ADR-0005); the layout lives in theme.rasi.
  colorsRasi = ''
    * {
      bg:            #${colors.base00};
      bg-alt:        #${colors.base0D};
      foreground:    #${colors.base01};
      selected:      #${colors.base0E};
      active:        #${colors.base0B};
      text-selected: #${colors.base00};
      text-color:    #${colors.base05};
      border-color:  #${colors.base0F};
      urgent:        #${colors.base0E};
    }
  '';
in {
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-unwrapped;
      extraConfig = {
        modi = "drun,filebrowser,run";
        show-icons = true;
        icon-theme = "Papirus";
        font = "Iosevka Nerd Font Mono 12";
        drun-display-format = "{icon} {name}";
        display-drun = " Apps";
        display-run = " Run";
        display-filebrowser = " File";
      };
      # Reference the native theme by name; it is installed below under
      # ~/.local/share/rofi/themes where rofi resolves @theme "theme".
      theme = "theme";
    };
  };

  # Generated palette (pure). Native theme.rasi is symlinked to the working tree
  # in designMode; rofi relaunches per-invocation so edits show on next open.
  xdg.configFile."rofi/colors.rasi".text = colorsRasi;
  xdg.dataFile."rofi/themes/theme.rasi".source = mkDesignSource {
    repo = "modules/home/rofi/theme.rasi";
    store = ./theme.rasi;
  };
}
