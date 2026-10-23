{...}: {
  imports = [
    ./eduroam.nix
    ./hardware.nix
    ./host-packages.nix
    ./nvim.nix
    ./power.nix
    ./tailscale.nix
    ./v4l2loopback.nix
    ./vscode.nix
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };
}
