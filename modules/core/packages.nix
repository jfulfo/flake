{pkgs, ...}: {
  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    virt-manager.enable = true;
    mtr.enable = true;
    adb.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    appimage-run # Needed For AppImage Support
    brightnessctl # For Screen Brightness Control
    cowsay # Great Fun Terminal Program
    docker-compose # Allows Controlling Docker From A Single File
    duf # Utility For Viewing Disk Usage In Terminal
    eza # Beautiful ls Replacement
    ffmpeg # Terminal Video / Audio Editing
    file-roller # Archive Manager
    fzf
    greetd.tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    htop # Simple Terminal Based System Monitor
    hyprpicker
    imv
    inxi
    killall
    libnotify
    libvirt
    lm_sensors
    lshw
    lxqt.lxqt-policykit
    meson
    mpv
    ncdu
    ninja
    nixfmt-rfc-style
    pavucontrol
    pciutils
    picard
    pkg-config
    pokeget-rs
    playerctl
    qbittorrent-enhanced
    ripgrep
    socat
    texliveFull
    unrar
    unzip
    usbutils
    v4l-utils
    virt-viewer
    wget
  ];
}
