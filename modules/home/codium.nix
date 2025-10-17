{pkgs, ...}: {
  programs.vscode = {
    # TODO: fix the bug where codium fails to display
    enable = true;
    package = pkgs.vscode-fhs;
  };
}
