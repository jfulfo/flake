{username, ...}: {
  imports = [
    ./eduroam.nix
    ./hardware.nix
    ./host-packages.nix
    ./power.nix
    ./tailscale.nix
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  home-manager.users.${username}.programs.vscode.profiles.default.userSettings."window.zoomLevel" = 1;
}
