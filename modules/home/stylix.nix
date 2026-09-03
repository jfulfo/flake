_: {
  stylix.targets = {
    waybar.enable = false;
    rofi.enable = false;
    hyprland.enable = false;
    hyprlock.enable = false;
    ghostty.enable = false;

    # stylix cannot discover zen profiles on its own; without this the target
    # is a no-op and warns. Must match a profile in programs.zen-browser.
    zen-browser.profileNames = ["default"];
  };
}
