{
  lib,
  pkgs,
  host,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../hosts/${host}
    ../../modules/drivers
    ../../modules/core
  ];
  nixpkgs.hostPlatform = {system = "x86_64-linux";};
  # modules/core uses NetworkManager; the installer base enables wpa_supplicant.
  # Force it off so the two don't both claim wireless.
  networking.wireless.enable = lib.mkForce false;
  # The installer image enables zfs, which is broken on the zen kernel (7.1.x is
  # past zfs's supported ceiling). No host here uses zfs, so drop it.
  boot.supportedFilesystems.zfs = lib.mkForce false;
}
