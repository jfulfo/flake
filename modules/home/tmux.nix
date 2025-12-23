{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    extraConfig = "
      set-option -g history-limit 100000
      set -g mouse on
      ";
  };
}
