{
  description = "jamie's nix config (based on Charlie's dotfiles)";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nvf.url = "github:notashelf/nvf";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    nixpkgs,
    lix-module,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    host = "cyberdeck";
    profile = "nvidia";
    username = "jamie";

    overlays = [
      (final: prev: {
        customPkgs = import ./modules/packages {pkgs = prev;};
      })
    ];
  in {
    nixosConfigurations = {
      amd = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [
          ./profiles/amd
          lix-module.nixosModules.default
          {nixpkgs.overlays = overlays;}
        ];
      };
      nvidia = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [
          ./profiles/nvidia
          lix-module.nixosModules.default
          {nixpkgs.overlays = overlays;}
        ];
      };
      nvidia-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [
          ./profiles/nvidia-laptop
          lix-module.nixosModules.default
          {nixpkgs.overlays = overlays;}
        ];
      };
      intel = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [
          ./profiles/intel
          lix-module.nixosModules.default
        ];
      };
      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [
          ./profiles/vm
          lix-module.nixosModules.default
          {nixpkgs.overlays = overlays;}
        ];
      };
      iso = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile;
        };
        modules = [
          ./profiles/iso
          lix-module.nixosModules.default
          {nixpkgs.overlays = overlays;}
        ];
      };
    };
  };
}
