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
      customPkgs.datacorn

      (agda.withPackages [
        agdaPackages._1lab
        agdaPackages.agda-categories
        agdaPackages.cubical
        agdaPackages.standard-library
      ])
      # fails to build 2025-11-15
      # ardour
      brightnessctl
      claude-code # unfortunately needed for work
      clock-rs
      dust
      # marked unsafe
      # element-desktop
      edopro # YGO simulator
      eza
      ffmpeg
      file-roller
      fzf
      # fails to build 2026-01-01
      # gemini-cli
      gimp
      tuigreet
      hyprpicker
      imv
      killall
      krabby
      libnotify
      libvirt
      lm_sensors
      lmms
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
      prusa-slicer
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
      cemu # wii u emu
      dolphin-emu # wii/gcn emu
      joycond
      joycond-cemuhook
      lumafly # HK mod manager
      melonDS #nds emu
      prismlauncher # minecraft launcher
      # # fails to build 2026-01-01
      # retroarch-free # generic emu
    ]
    ++ lib.optionals config.variables.gamedev [
      # broken 2026-01-01
      # aseprite
      godot
    ]
    ++ lib.optionals config.variables.silly [
      cmatrix
      cowsay
      fortune-kind
      pipes-rs
    ];
}
