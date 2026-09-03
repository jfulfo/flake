{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    # `wlr.enable` is deliberately off: it installs xdg-desktop-portal-wlr,
    # which claims the same Screenshot and ScreenCast interfaces as
    # xdg-desktop-portal-hyprland. With no *-portals.conf shipped to arbitrate,
    # the frontend falls back to lexicographic order, so which backend answers a
    # screen-share request is incidental. hyprland's supersedes wlr's here (it
    # also provides GlobalShortcuts and InputCapture), so install only that one.
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      # Must be listed here, not only in configPackages: the NixOS module feeds
      # services.dbus.packages and systemd.packages from extraPortals alone, so
      # a configPackages-only backend never gets its units registered.
      pkgs.xdg-desktop-portal-hyprland
    ];
    # pkgs.xdg-desktop-portal itself is not listed: it is the frontend, and the
    # module already prepends it to extraPortals.
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
