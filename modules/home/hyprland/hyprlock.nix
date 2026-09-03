{
  username,
  config,
  ...
}: let
  inherit (config.lib.stylix) colors;
  inherit (config.variables) defaultWallpaper;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };
      background = [
        {
          path = "/home/${username}/pictures/wallpapers/${defaultWallpaper}";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(${colors.base05})";
          inner_color = "rgb(${colors.base0D})";
          outer_color = "rgb(${colors.base00})";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
    };
  };
}
