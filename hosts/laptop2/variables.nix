{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "CharredLee";
  gitEmail = "31701136+CharredLee@users.noreply.github.com";

  # Hyprland Settings
  extraMonitorSettings = "
    monitor = ,1920x1080@60,auto,1
  ";
  extraHardwareSettings = "";
  defaultWallpaper = "hollow-knight.png";

  theme = "catppuccin-mocha";

  fontSizes = {
    applications = 14;
    terminal = 18;
    desktop = 12;
    popups = 12;
  };

  # Waybar Settings
  clock24h = true;

  # variables which toggle packages
  gaming = false;
  texlive = false;
  silly = false;

  # Program Options
  browser = "zen"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "kitty"; # Set Default System Terminal
  keyboardLayout = "us";
  consoleKeyMap = "us";

  editor = "nvim";
  EDITOR = "nvim";
  VISUAL = "nvim";

  # For Nvidia Prime support
  intelID = "PCI:1:0:0";
  nvidiaID = "PCI:0:2:0";

  # Enable NFS
  enableNFS = true;
}
