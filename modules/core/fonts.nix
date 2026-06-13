{pkgs, ...}: let
  # external-fonts = pkgs.stdenvNoCC.mkDerivation {
  #   pname = "external-fonts";
  #   version = "1.0";
  #   src = ./fonts;
  #   installPhas = ''
  #     mkdir -p $out/share/fonts/truetype
  #     cp $src/*.ttc $out/share/fonts/truetype/
  #   '';
  # };
in {
  fonts = {
    packages = [
      # external-fonts
      pkgs.noto-fonts-color-emoji
      pkgs.noto-fonts-cjk-sans
      pkgs.font-awesome
      pkgs.symbola
      pkgs.material-icons
    ];
  };
}
