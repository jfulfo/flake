{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.variables) texlive;
  # texlive.combine is deprecated and slated for removal in nixpkgs 27.05;
  # texliveSmall.withPackages is the replacement. scheme-full pulls the same
  # closure the old `combine { scheme-full }` did.
  tex = pkgs.texliveSmall.withPackages (ps: [ps.scheme-full]);
in {
  home.packages = lib.mkIf texlive [
    tex
  ];
}
