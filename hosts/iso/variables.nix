{
  # Host identity ( read by flake.nix to wire drivers + user )
  profile = "iso"; # live installer image under ./profiles
  user = "lottie";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "658060";
  gitEmail = "31701136+658060@users.noreply.github.com";

  # Only keys that differ from the modules/core/variables.nix defaults.
  extraMonitorSettings = [
    { output = ""; mode = "1920x1080@60"; position = "auto"; scale = "1"; }
  ];
}
