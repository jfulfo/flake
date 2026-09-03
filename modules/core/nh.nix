{
  pkgs,
  config,
  ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    # variables.dotfilesPath is the one place that knows where the working tree
    # lives. This used to hardcode ~/.dotfiles, which does not exist on hosts
    # that check out elsewhere, so a bare `nh os switch` failed with "points to
    # local path ... but that path does not exist".
    flake = config.variables.dotfilesPath;
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
