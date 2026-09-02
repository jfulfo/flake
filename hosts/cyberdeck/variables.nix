{
  # Host identity ( read by flake.nix to wire drivers + user )
  profile = "amd"; # driver bundle under ./profiles
  user = "holly";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "jfulfo";
  gitEmail = "47907450+jfulfo@users.noreply.github.com";

  # Only keys that differ from the modules/core/variables.nix defaults.
  extraMonitorSettings = [
    { output = "";         mode = "1920x1200@60";  position = "auto";      scale = "1"; }
  ];

  fontSizes = {
    applications = 14;
    terminal = 18;
    desktop = 12;
    popups = 12;
  };

  dotfilesPath = "/home/${config.user}/flake";

  gaming = true;
  texlive = true;

  enableNFS = true;
}
