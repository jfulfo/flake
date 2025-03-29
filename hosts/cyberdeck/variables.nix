{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "jfulfo";
  gitEmail = "47907450+jfulfo@users.noreply.github.com";

  # Hyprland Settings
  extraMonitorSettings = "monitor = ,1920x1200@60,0x0,1";
  extraHardwareSettings = "";
  defaultWallpaper = "tree.jpgs";
  fontSizes = {
    applications = 14;
    terminal = 16;
    desktop = 13;
    popups = 14;
  };

  # Waybar Settings
  clock24h = true;

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
