{
  designMode = true;

  # Host identity ( read by flake.nix to wire drivers + user )
  profile = "amd"; # driver bundle under ./profiles
  user = "lottie";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "658060";
  gitEmail = "31701136+658060@users.noreply.github.com";

  # Only keys that differ from the modules/core/variables.nix defaults.
  extraMonitorSettings = [
    { output = "";         mode = "1920x1080@60";  position = "auto";      scale = "1"; }
    { output = "HDMI-A-1"; mode = "3840x2160@60";  position = "auto-left"; scale = "1"; }
  ];

  fontSizes = {
    applications = 14;
    terminal = 18;
    desktop = 12;
    popups = 12;
  };

  gaming = true;
  texlive = true;

  enableNFS = true;
}
