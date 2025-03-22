{
  pkgs,
  username,
  ...
}: {
  home.packages = with pkgs; [
    swww
    grim
    slurp
    wl-clipboard
    swappy
    ydotool
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };
  # Place Files Inside Home Directory
  home.file = {
    "pictures/wallpapers" = {
      source = ../../../wallpapers;
      recursive = true;
    };
    ".config/swappy/config".text = ''
      [Default]
      save_dir=/home/${username}/pictures/Screenshots
      save_filename_format=swappy-%Y%m%d-%H%M%S.png
      show_panel=false
      line_size=5
      text_size=20
      text_font=Ubuntu
      paint_mode=brush
      early_exit=true
      fill_shape=false
    '';
  };
}
