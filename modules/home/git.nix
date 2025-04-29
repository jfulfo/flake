{host, ...}: let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername gitEmail;
in {
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
    ignores = [
      ".envrc"
      ".env"
      ".venv"
      ".direnv"
      "shell.nix"
    ];
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
