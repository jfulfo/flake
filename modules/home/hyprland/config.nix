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
        kb_layout = "${keyboardLayout}";
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
          clickfinger_behavior = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      general = {
        "$modifier" = "SUPER";
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
        "$modifier,Return,exec,${terminal}"
        "$modifier SHIFT,Return,exec,pypr toggle term"
        "$modifier,D,exec,rofi-launcher"
        "$modifier SHIFT,W,exec,web-search"
        "$modifier ALT,W,exec,wallsetter-visual"
        "$modifier SHIFT,N,exec,swaync-client -rs"
        "$modifier,W,exec,${browser}"
        "$modifier,E,exec,emopicker9000"
        "$modifier,S,exec,screenshootin"
        "$modifier SHIFT,D,exec,vesktop --enable-features=WebRTCPipeWireCapturer"
        "$modifier,O,exec,obs"
        "$modifier,C,exec,hyprpicker -a"
        "$modifier,G,exec,gamemode"
        "$modifier,T,exec,thunar"
        "$modifier SHIFT,T,exec,pypr toggle thunar"
        "$modifier,M,exec,pavucontrol"
        "$modifier,Q,killactive,"
        "$modifier,P,exec,pypr toggle volume"
        "$modifier SHIFT,P,pseudo,"
        "$modifier SHIFT,I,togglesplit,"
        "$modifier,F,fullscreen,"
        "$modifier CTRL,B,exec,pkill -SIGUSR1 waybar || waybar"
        "$modifier CONTROL,F,togglefloating,"
        "$modifier CONTROL,C,exit,"
        "$modifier CONTROL,left,movewindow,l"
        "$modifier CONTROL,right,movewindow,r"
        "$modifier CONTROL,up,movewindow,u"
        "$modifier CONTROL,down,movewindow,d"
        "$modifier SHIFT,left,resizeactive, -30 0"
        "$modifier SHIFT,right,resizeactive, 30 0"
        "$modifier SHIFT,up,resizeactive, 0 -30"
        "$modifier SHIFT,down,resizeactive, 0 30"
        "$modifier,left,movefocus,l"
        "$modifier,right,movefocus,r"
        "$modifier,up,movefocus,u"
        "$modifier,down,movefocus,d"
        "$modifier,code:10,workspace,1"
        "$modifier,code:11,workspace,2"
        "$modifier,code:12,workspace,3"
        "$modifier,code:13,workspace,4"
        "$modifier,code:14,workspace,5"
        "$modifier,code:15,workspace,6"
        "$modifier,code:16,workspace,7"
        "$modifier,code:17,workspace,8"
        "$modifier,code:18,workspace,9"
        "$modifier,code:19,workspace,10"
        "$modifier CONTROL,SPACE,movetoworkspace,special"
        "$modifier,SPACE,togglespecialworkspace"
        "$modifier SHIFT,code:10,movetoworkspace,1"
        "$modifier SHIFT,code:11,movetoworkspace,2"
        "$modifier SHIFT,code:12,movetoworkspace,3"
        "$modifier SHIFT,code:13,movetoworkspace,4"
        "$modifier SHIFT,code:14,movetoworkspace,5"
        "$modifier SHIFT,code:15,movetoworkspace,6"
        "$modifier SHIFT,code:16,movetoworkspace,7"
        "$modifier SHIFT,code:17,movetoworkspace,8"
        "$modifier SHIFT,code:18,movetoworkspace,9"
        "$modifier SHIFT,code:19,movetoworkspace,10"
        "$modifier CONTROL,code:10,movetoworkspacesilent,1"
        "$modifier CONTROL,code:11,movetoworkspacesilent,2"
        "$modifier CONTROL,code:12,movetoworkspacesilent,3"
        "$modifier CONTROL,code:13,movetoworkspacesilent,4"
        "$modifier CONTROL,code:14,movetoworkspacesilent,5"
        "$modifier CONTROL,code:15,movetoworkspacesilent,6"
        "$modifier CONTROL,code:16,movetoworkspacesilent,7"
        "$modifier CONTROL,code:17,movetoworkspacesilent,8"
        "$modifier CONTROL,code:18,movetoworkspacesilent,9"
        "$modifier CONTROL,code:19,movetoworkspacesilent,10"
        "$modifier,mouse_down,workspace, e+1"
        "$modifier,mouse_up,workspace, e-1"
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
        "$modifier, mouse:272, movewindow"
        "$modifier, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "tag +file-manager, class:^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
        "tag +terminal, class:^(Alacritty|kitty|kitty-dropterm)$"
        "tag +browser, class:^(Brave-browser(-beta|-dev|-unstable)?)$"
        "tag +browser, class:^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
        "tag +browser, class:^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$"
        "tag +browser, class:^([Zz]en(-browser)?(-beta)?)$"
        "tag +browser, class:^([Tt]horium-browser|[Cc]achy-browser)$"
        "tag +projects, class:^(codium|codium-url-handler|VSCodium)$"
        "tag +projects, class:^(VSCode|code-url-handler)$"
        "tag +im, class:^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
        "tag +im, class:^([Ff]erdium)$"
        "tag +im, class:^([Ww]hatsapp-for-linux)$"
        "tag +im, class:^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$"
        "tag +im, class:^(teams-for-linux)$"
        "tag +games, class:^(gamescope)$"
        "tag +games, class:^(steam_app_\d+)$"
        "tag +gamestore, class:^([Ss]team)$"
        "tag +gamestore, title:^([Ll]utris)$"
        "tag +gamestore, class:^(com.heroicgameslauncher.hgl)$"
        "tag +settings, class:^(gnome-disks|wihotspot(-gui)?)$"
        "tag +settings, class:^([Rr]ofi)$"
        "tag +settings, class:^(file-roller|org.gnome.FileRoller)$"
        "tag +settings, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
        "tag +settings, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "tag +settings, class:^(nwg-look|qt5ct|qt6ct|[Yy]ad)$"
        "tag +settings, class:(xdg-desktop-portal-gtk)"
        "move 72% 7%,title:^(Picture-in-Picture)$"
        "center, class:^([Ff]erdium)$"
        "center, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "center, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)"
        "center, title:^(Authentication Required)$"
        "idleinhibit fullscreen, class:^(*)$"
        "idleinhibit fullscreen, title:^(*)$"
        "idleinhibit fullscreen, fullscreen:1"
        "float, tag:settings*"
        "float, class:^([Ff]erdium)$"
        "float, title:^(Picture-in-Picture)$"
        "float, class:^(mpv|com.github.rafostar.Clapper)$"
        "float, title:^(Authentication Required)$"
        "float, class:(codium|codium-url-handler|VSCodium), title:negative:(.*codium.*|.*VSCodium.*)"
        "float, class:^(com.heroicgameslauncher.hgl)$, title:negative:(Heroic Games Launcher)"
        "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"
        "float, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)"
        "float, initialTitle:(Add Folder to Workspace)"
        "float, initialTitle:(Open Files)"
        "float, initialTitle:(wants to save)"
        "size 70% 60%, initialTitle:(Open Files)"
        "size 70% 60%, initialTitle:(Add Folder to Workspace)"
        "size 70% 70%, tag:settings*"
        "size 60% 70%, class:^([Ff]erdium)$"
        "opacity 1.0 1.0, tag:browser*"
        "opacity 0.9 0.8, tag:projects*"
        "opacity 0.94 0.86, tag:im*"
        "opacity 0.9 0.8, tag:file-manager*"
        "opacity 0.8 0.7, tag:terminal*"
        "opacity 0.8 0.7, tag:settings*"
        "opacity 0.8 0.7, class:^(gedit|org.gnome.TextEditor|mousepad)$"
        "opacity 0.9 0.8, class:^(seahorse)$ # gnome-keyring gui"
        "opacity 0.95 0.75, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "keepaspectratio, title:^(Picture-in-Picture)$"
        "noblur, tag:games*"
        "fullscreen, tag:games*"

        # workspace rules
        "workspace 2, tag:browser"
        "workspace 5, tag:games"
        "workspace 5, tag:gamestore"
        "workspace 7, tag:im"
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
      ];
    };

    extraConfig = "
      monitor=,preferred,auto,auto
      ${extraMonitorSettings}
      ${extraHardwareSettings}
    ";
  };
}
