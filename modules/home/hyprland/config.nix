{
  username,
  config,
  ...
}: let
  inherit
    (config.variables)
    accent0
    accent1
    browser
    terminal
    extraMonitorSettings
    extraHardwareSettings
    defaultWallpaper
    keyboardLayout
    ;
in {
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "killall -q swww-daemon;sleep .5 && swww-daemon"
        "killall -q waybar;sleep .5 && waybar"
        "killall -q swaync;sleep .5 && swaync"
        "nm-applet --indicator"
        "lxqt-policykit-agent"
        "pypr &"
        "sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/${defaultWallpaper}"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "${keyboardLayout}";
        kb_options = [
          "grp:alt_caps_toggle"
          "caps:super"
        ];
        numlock_by_default = true;
        repeat_delay = 300;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          scroll_factor = 0.8;
        };
      };

      general = {
        "$term" = "kitty";
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" = "rgb(${accent1}) rgb(${accent0}) 45deg";
        "col.inactive_border" = "rgb(${config.lib.stylix.colors.base01})";
      };

      misc = {
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      bind = [
        "SUPER,Return,exec,${terminal}"
        "SUPER SHIFT,Return,exec,pypr toggle term"
        "SUPER,D,exec,rofi-launcher"
        "SUPER SHIFT,W,exec,web-search"
        "SUPER ALT,W,exec,wallsetter-visual"
        "SUPER SHIFT,N,exec,swaync-client -rs"
        "SUPER,W,exec,${browser}"
        "SUPER,E,exec,emopicker9000"
        "SUPER,S,exec,screenshootin"
        "SUPER SHIFT,D,exec,vesktop --enable-features=WebRTCPipeWireCapturer"
        "SUPER,O,exec,obs"
        "SUPER,C,exec,hyprpicker -a"
        "SUPER,G,exec,gamemode"
        "SUPER,T,exec,thunar"
        "SUPER SHIFT,T,exec,pypr toggle thunar"
        "SUPER,M,exec,pavucontrol"
        "SUPER,Q,killactive,"
        "SUPER,P,exec,pypr toggle volume"
        "SUPER SHIFT,P,pseudo,"
        "SUPER SHIFT,I,togglesplit,"
        "SUPER,F,fullscreen,"
        "SUPER CTRL,B,exec,pkill -SIGUSR1 waybar || waybar"
        "SUPER CONTROL,F,togglefloating,"
        "SUPER CONTROL,C,exit,"

        # vim motions style window movement
        "SUPER CONTROL,H,movewindow,l"
        "SUPER CONTROL,L,movewindow,r"
        "SUPER CONTROL,K,movewindow,u"
        "SUpER CONTROL,J,movewindow,d"
        "SUPER SHIFT,H,resizeactive, -30 0"
        "SUPER SHIFT,L,resizeactive, 30 0"
        "SUPER SHIFT,K,resizeactive, 0 -30"
        "SUPER SHIFT,J,resizeactive, 0 30"
        "SUPER,H,movefocus,l"
        "SUPER,L,movefocus,r"
        "SUPER,K,movefocus,u"
        "SUPER,J,movefocus,d"
        # arrow key counterparts
        "SUPER CONTROL,left,movewindow,l"
        "SUPER CONTROL,right,movewindow,r"
        "SUPER CONTROL,up,movewindow,u"
        "SUPER CONTROL,down,movewindow,d"
        "SUPER SHIFT,left,resizeactive, -30 0"
        "SUPER SHIFT,right,resizeactive, 30 0"
        "SUPER SHIFT,up,resizeactive, 0 -30"
        "SUPER SHIFT,down,resizeactive, 0 30"
        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"

        "SUPER,code:10,workspace,1"
        "SUPER,code:11,workspace,2"
        "SUPER,code:12,workspace,3"
        "SUPER,code:13,workspace,4"
        "SUPER,code:14,workspace,5"
        "SUPER,code:15,workspace,6"
        "SUPER,code:16,workspace,7"
        "SUPER,code:17,workspace,8"
        "SUPER,code:18,workspace,9"
        "SUPER,code:19,workspace,10"
        "SUPER CONTROL,SPACE,movetoworkspace,special"
        "SUPER,SPACE,togglespecialworkspace"
        "SUPER SHIFT,code:10,movetoworkspace,1"
        "SUPER SHIFT,code:11,movetoworkspace,2"
        "SUPER SHIFT,code:12,movetoworkspace,3"
        "SUPER SHIFT,code:13,movetoworkspace,4"
        "SUPER SHIFT,code:14,movetoworkspace,5"
        "SUPER SHIFT,code:15,movetoworkspace,6"
        "SUPER SHIFT,code:16,movetoworkspace,7"
        "SUPER SHIFT,code:17,movetoworkspace,8"
        "SUPER SHIFT,code:18,movetoworkspace,9"
        "SUPER SHIFT,code:19,movetoworkspace,10"
        "SUPER CONTROL,code:10,movetoworkspacesilent,1"
        "SUPER CONTROL,code:11,movetoworkspacesilent,2"
        "SUPER CONTROL,code:12,movetoworkspacesilent,3"
        "SUPER CONTROL,code:13,movetoworkspacesilent,4"
        "SUPER CONTROL,code:14,movetoworkspacesilent,5"
        "SUPER CONTROL,code:15,movetoworkspacesilent,6"
        "SUPER CONTROL,code:16,movetoworkspacesilent,7"
        "SUPER CONTROL,code:17,movetoworkspacesilent,8"
        "SUPER CONTROL,code:18,movetoworkspacesilent,9"
        "SUPER CONTROL,code:19,movetoworkspacesilent,10"
        "SUPER,mouse_down,workspace, e+1"
        "SUPER,mouse_up,workspace, e-1"
        "ALT,Tab,cyclenext"
        "ALT,Tab,bringactivetotop"
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
      ];

      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
      };

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, x11"
        "MOZ_ENABLE_WAYLAND, 1"

        # Nvidia settings
        # TODO: also move this to host variables.
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,Nvidia"
        "__GL_VRR_ALLOWED,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_DRM_NO_ATOMIC,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      # more Nvidia-specific settings.
      # below settings are what stop electron screen flickering with the 2070S.
      # note: these changes increase power consumption.
    };

    extraConfig = "
windowrule {
  name = windowrule-1
  tag = +file-manager
  match:class = ^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$
}

windowrule {
  name = windowrule-2
  tag = +terminal
  match:class = ^(Alacritty|kitty|kitty-dropterm)$
}

windowrule {
  name = windowrule-3
  tag = +browser
  match:class = ^(Brave-browser(-beta|-dev|-unstable)?)$
}

windowrule {
  name = windowrule-4
  tag = +browser
  match:class = ^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$
}

windowrule {
  name = windowrule-5
  tag = +browser
  match:class = ^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$
}

windowrule {
  name = windowrule-6
  tag = +browser
  match:class = ^([Zz]en(-browser)?(-beta)?)$
}

windowrule {
  name = windowrule-7
  tag = +browser
  match:class = ^([Tt]horium-browser|[Cc]achy-browser)$
}

windowrule {
  name = windowrule-8
  tag = +projects
  match:class = ^(codium|codium-url-handler|VSCodium)$
}

windowrule {
  name = windowrule-9
  tag = +projects
  match:class = ^(VSCode|code-url-handler)$
}

windowrule {
  name = windowrule-10
  tag = +im
  match:class = ^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$
}

windowrule {
  name = windowrule-11
  tag = +im
  center = on
  float = on
  size = (monitor_w*0.6) (monitor_h*0.7)
  match:class = ^([Ff]erdium)$
}

windowrule {
  name = windowrule-12
  tag = +im
  match:class = ^([Ww]hatsapp-for-linux)$
}

windowrule {
  name = windowrule-13
  tag = +im
  match:class = ^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$
}

windowrule {
  name = windowrule-14
  tag = +im
  match:class = ^(teams-for-linux)$
}

windowrule {
  name = windowrule-15
  tag = +games
  match:class = ^(gamescope)$
}

windowrule {
  name = windowrule-16
  tag = +games
  match:class = ^(steam_app_d+)$
}

windowrule {
  name = windowrule-17
  tag = +gamestore
  match:class = ^([Ss]team)$
}

windowrule {
  name = windowrule-18
  tag = +gamestore
  match:title = ^([Ll]utris)$
}

windowrule {
  name = windowrule-19
  tag = +gamestore
  match:class = ^(com.heroicgameslauncher.hgl)$
}

windowrule {
  name = windowrule-20
  tag = +settings
  match:class = ^(gnome-disks|wihotspot(-gui)?)$
}

windowrule {
  name = windowrule-21
  tag = +settings
  match:class = ^([Rr]ofi)$
}

windowrule {
  name = windowrule-22
  tag = +settings
  match:class = ^(file-roller|org.gnome.FileRoller)$
}

windowrule {
  name = windowrule-23
  tag = +settings
  match:class = ^(nm-applet|nm-connection-editor|blueman-manager)$
}

windowrule {
  name = windowrule-24
  tag = +settings
  center = on
  match:class = ^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$
}

windowrule {
  name = windowrule-25
  tag = +settings
  match:class = ^(nwg-look|qt5ct|qt6ct|[Yy]ad)$
}

windowrule {
  name = windowrule-26
  tag = +settings
  match:class = (xdg-desktop-portal-gtk)
}

windowrule {
  name = windowrule-27
  move = ((monitor_w*0.72)) ((monitor_h*0.07))
  float = on
  opacity = 0.95 0.75
  pin = on
  keep_aspect_ratio = on
  match:title = ^(Picture-in-Picture)$
}

windowrule {
  name = windowrule-28
  center = on
  float = on
  match:class = ([Tt]hunar)
  match:title = negative:(.*[Tt]hunar.*)
}

windowrule {
  name = windowrule-29
  center = on
  float = on
  match:title = ^(Authentication Required)$
}

windowrule {
  name = windowrule-30
  idle_inhibit = fullscreen
  match:class = ^(*)$
}

windowrule {
  name = windowrule-31
  idle_inhibit = fullscreen
  match:title = ^(*)$
}

windowrule {
  name = windowrule-32
  idle_inhibit = fullscreen
  match:fullscreen = 1
}

windowrule {
  name = windowrule-33
  float = on
  size = (monitor_w*0.7) (monitor_h*0.7)
  opacity = 0.8 0.7
  match:tag = settings*
}

windowrule {
  name = windowrule-34
  float = on
  match:class = ^(mpv|com.github.rafostar.Clapper)$
}

windowrule {
  name = windowrule-35
  float = on
  match:class = (codium|codium-url-handler|VSCodium)
  match:title = negative:(.*codium.*|.*VSCodium.*)
}

windowrule {
  name = windowrule-36
  float = on
  match:class = ^(com.heroicgameslauncher.hgl)$
  match:title = negative:(Heroic Games Launcher)
}

windowrule {
  name = windowrule-37
  float = on
  match:class = ^([Ss]team)$
  match:title = negative:^([Ss]team)$
}

windowrule {
  name = windowrule-38
  float = on
  size = (monitor_w*0.7) (monitor_h*0.6)
  match:initial_title = (Add Folder to Workspace)
}

windowrule {
  name = windowrule-39
  float = on
  size = (monitor_w*0.7) (monitor_h*0.6)
  match:initial_title = (Open Files)
}

windowrule {
  name = windowrule-40
  float = on
  match:initial_title = (wants to save)
}

windowrule {
  name = windowrule-41
  opacity = 1.0 1.0
  match:tag = browser*
}

windowrule {
  name = windowrule-42
  opacity = 0.9 0.8
  match:tag = projects*
}

windowrule {
  name = windowrule-43
  opacity = 0.94 0.86
  match:tag = im*
}

windowrule {
  name = windowrule-44
  opacity = 0.9 0.8
  match:tag = file-manager*
}

windowrule {
  name = windowrule-45
  opacity = 0.8 0.7
  match:tag = terminal*
}

windowrule {
  name = windowrule-46
  opacity = 0.8 0.7
  match:class = ^(gedit|org.gnome.TextEditor|mousepad)$
}

windowrule {
  name = windowrule-47
  opacity = 0.9 0.8
  match:class = ^(seahorse)$ # gnome-keyring gui
}

windowrule {
  name = windowrule-48
  no_blur = on
  fullscreen = on
  match:tag = games*
}

windowrule {
  name = windowrule-49
  workspace = 2
  match:tag = browser
}

windowrule {
  name = windowrule-50
  workspace = 5
  match:tag = games
}

windowrule {
  name = windowrule-51
  workspace = 5
  match:tag = gamestore
}

windowrule {
  name = windowrule-52
  workspace = 7
  match:tag = im
}

monitor=,preferred,auto,auto
${extraMonitorSettings}
${extraHardwareSettings}
    ";
  };
}
