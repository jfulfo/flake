# Generic QEMU/KVM guest hardware. The vm profile flips on guest-services;
# this provides a bootable disk layout so `nixos-rebuild build-vm` works.
{
  modulesPath,
  lib,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];

  # Bootloader (grub/EFI) is configured by modules/core/boot.nix; only the
  # root filesystem is host-specific here.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
