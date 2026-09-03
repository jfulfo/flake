{
  # Host identity ( read by flake.nix to wire drivers + user )
  profile = "amd"; # driver bundle under ./profiles
  user = "holly";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "jfulfo";
  gitEmail = "47907450+jfulfo@users.noreply.github.com";

  # Only keys that differ from the modules/core/variables.nix defaults.
  extraMonitorSettings = [
    {
      output = "";
      mode = "1920x1200@60";
      position = "auto";
      scale = "1";
    }
  ];

  fontSizes = {
    applications = 14;
    terminal = 18;
    desktop = 12;
    popups = 12;
  };

  # The zen-browser flake input installs its binary as `zen-beta`, not `zen`
  # (the upstream default), so SUPER + W ran a command that did not exist.
  browser = "zen-beta";

  defaultWallpaper = "forest.png";
  dotfilesPath = "/home/holly/flake"; # TODO put in variable

  gaming = false;
  texlive = false;

  enableNFS = true;
}
