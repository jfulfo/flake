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

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "dotnet-sdk-6.0.428"
      "dotnet-runtime-6.0.36"
    ];
  };

  environment.systemPackages = with pkgs; [
    appimage-run
    brightnessctl
    cmatrix
    cowsay
    docker-compose
    duf
    eza
    fd
    ffmpeg
    file-roller
    fzf
    gedit
    greetd.tuigreet
    htop
    hyprpicker
    imv
    inxi
    killall
    krabby
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
    pipes-rs
    pkg-config
    playerctl
    qbittorrent-enhanced
    retroarch-free
    ripgrep
    socat
    unrar
    unzip
    usbutils
    v4l-utils
    virt-viewer
    wget
  ];
}
