{pkgs, ...}: {
  home.packages = with pkgs; [
    eddie
  ];
}
