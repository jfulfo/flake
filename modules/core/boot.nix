{ pkgs, config, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernel.sysctl = { "vm.max_map_count" = 2147483642; };

    loader = {
      efi.canTouchEfiVariables = true;
      grub ={
        enable = true;
        device = "nodev";
        efiSupport = true;
	useOSProber = true;
	theme = "${
          (pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "grub";
	    rev = "2a5c8be8185dae49dd22030df45860df8c796312";
	    hash = "sha256-20D1EcV8SWOd5BLdAc6FaQu3onha0+aS5yA/GK8Ra0g=";
          })
        }/src/catppuccin-mocha-grub-theme";
      };
      timeout = 2;
    };
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth.enable = true;
  };
}
