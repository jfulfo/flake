{config, ...}: let
  inherit (config.variables) gitUsername gitEmail;
in {
  programs.git = {
    enable = true;
    ignores = [
      ".env"
      ".envrc"
      ".venv"
      ".direnv"
      "shell.nix"
    ];
    settings = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "${gitUsername}";
        email = "${gitEmail}";
      };
    };
  };
}
