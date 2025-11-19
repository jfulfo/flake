{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
      # fails to build 2025-11-02
      # batgrep
    ];
  };
}
