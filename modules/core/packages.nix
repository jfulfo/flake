{
  config,
  pkgs,
  ...
}: {
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

  environment.systemPackages = with pkgs;
    [
      # kingler has some serious bugs
      # e.g. because names are changed, pokemon with different forms are just... not printable to the terminal
      # so `kingler name shaymin` doesn't work, and neither does `kingler name shaymin`
      # customPkgs.kingler

      ardour
      brightnessctl
      clock-rs
      dust
      electrum-ltc
      element-desktop
      eza
      ffmpeg
      file-roller
      fzf
      gimp
      tuigreet
      hyprpicker
      imv
      killall
      krabby
      libnotify
      libvirt
      lm_sensors
      lxqt.lxqt-policykit
      mask
      masklint
      mpv
      mullvad-vpn
      nicotine-plus
      obs-studio
      pavucontrol
      pciutils
      picard
      playerctl
      qbittorrent-enhanced
      quickemu
      ripgrep
      socat
      unrar
      unzip
      usbutils
      v4l-utils
      wget
      zoxide
    ]
    ++ lib.optionals config.variables.gaming [
      # TODO: move retroarch to ../home, add config
      azahar # 3ds emu
      cemu # wii u emu
      dolphin-emu # wii/gcn emu
      edopro # YGO simulator
      joycond
      joycond-cemuhook
      lumafly # HK mod manager
      melonDS #nds emu
      prismlauncher # minecraft launcher
      retroarch-free # generic emu
    ]
    ++ lib.optionals config.variables.gamedev [
      aseprite
      godot
    ]
    ++ lib.optionals config.variables.silly [
      cmatrix
      cowsay
      fortune-kind
      pipes-rs
    ];
}
