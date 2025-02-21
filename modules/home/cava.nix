{ pkgs, ... }:
{
  programs.cava = {
    enable = true;
  };

  # copied from catppuccin/cava
  xdg.configFile."cava/config".text = ''

    [general]
    autosens = 1
    overshoot = 0

    [color]
    gradient = 1
    gradient_count = 8

    gradient_color_1 = '#81c8be'
    gradient_color_2 = '#99d1db'
    gradient_color_3 = '#85c1dc'
    gradient_color_4 = '#8caaee'
    gradient_color_5 = '#ca9ee6'
    gradient_color_6 = '#f4b8e4'
    gradient_color_7 = '#ea999c'
    gradient_color_8 = '#e78284'
  '';
}
