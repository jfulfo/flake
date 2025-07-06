{pkgs ? import <nixpkgs> {}}: {
  kingler = pkgs.callPackage ./kingler {};
}
