{
  pkgs,
  config,
  ...
}: let
  inherit (config.variables) fontSizes;
in {
  # Styling Options
  stylix = {
    enable = true;
    # not needed because wallpaper is managed by swww
    # image = ../../wallpapers/hollow-knight.png;
    # catppuccin-mocha base16Scheme
    base16Scheme = {
      base00 = "1e1e2e";
      base01 = "181825";
      base02 = "313244";
      base03 = "45475a";
      base04 = "585b70";
      base05 = "cdd6f4";
      base06 = "f5e0dc";
      base07 = "b4befe";
      base08 = "f38ba8";
      base09 = "fab387";
      base0A = "f9e2af";
      base0B = "a6e3a1";
      base0C = "94e2d5";
      base0D = "89b4fa";
      base0E = "cba6f7";
      base0F = "f2cdcd";
    };
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
}
