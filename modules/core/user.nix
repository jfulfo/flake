{
  pkgs,
  inputs,
  config,
  username,
  host,
  profile,
  ...
}: let
  inherit (config.variables) gitUsername;
in {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs username host profile;};
    users.${username} = {
      # pass variables to home manager
      _module.args.systemVariables = config.variables;
      imports = [./../home];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        # this need not be updated for the actual state version to be updated.
        stateVersion = "23.11";
      };
      programs.home-manager.enable = true;
    };
  };
  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [
      "adbusers"
      "dialout"
      "docker"
      "libvirtd"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = ["${username}"];
}
