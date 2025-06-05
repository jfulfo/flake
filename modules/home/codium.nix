{pkgs, ...}: {
  programs.vscode = {
    # TODO: fix the bug where codium fails to display
    enable = false;
    package = pkgs.vscodium-fhs;
  };
}
