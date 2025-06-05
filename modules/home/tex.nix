{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.variables) texlive;
  latex-custom-packages = pkgs.stdenvNoCC.mkDerivation {
    name = "latex-custom-packages";
    src = ../../texmf;
    installPhase = "cp -r $src $out";
    passthru.tlType = "run";
  };
  texlive-custom-packages = {
    pkgs = [latex-custom-packages];
  };
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full;
    inherit texlive-custom-packages;
  };
in {
  home.packages = lib.mkIf texlive [
    tex
  ];
}
