{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.variables) fontSizes theme;
  palettes = import ./palettes.nix theme;
in {
  # Styling Options
  config = {
    stylix = {
      enable = true;
      # not needed because wallpaper is managed by swww
      # image = ../../wallpapers/hollow-knight.png;

      base16Scheme = palettes.activeBase16;
      polarity = "dark";
      opacity.terminal = 1.0;
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.iosevka;
          name = "Iosevka Nerd Font";
        };
        emoji = config.stylix.fonts.monospace;
        sansSerif = {
          package = pkgs.montserrat;
          name = "Montserrat";
        };
        # no serifs
        serif = config.stylix.fonts.sansSerif;

        sizes = fontSizes;
      };
      targets = {
        grub.enable = true;
      };
    };

    variables = {
      inherit (palettes.activeScheme) colors accent0 accent1;
    };
  };
}
