{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.variables) texlive;
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full;
  };
in {
  home.packages = lib.mkIf texlive [
    tex
  ];
}
