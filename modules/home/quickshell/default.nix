# modules/home/quickshell — ADR-0005 native UI, greenfield.
#
# quickshell is a QtQuick/QML-based Wayland shell. We author the shell as native
# .qml files (real LSP/highlighting, and quickshell hot-reloads QML on change),
# while the color palette stays Nix-driven: `Theme.qml` is generated from stylix
# and instantiated by shell.qml.
#
# Status: scaffold. quickshell's own stub used to table this "until 1.0"; at
# 0.3.0 the Hyprland integration is solid enough to start iterating. This is a
# minimal bar (workspaces + clock) meant to be grown live in designMode —
# `qs -p ~/.config/quickshell` then edit shell.qml and watch it reload. It does
# not replace waybar yet; nothing autostarts it.
{
  config,
  pkgs,
  inputs,
  mkDesignSource,
  ...
}: let
  c = config.lib.stylix.colors;
  # Generated palette component. Bulk QML stays native + reloadable; the palette
  # is regenerated from the active stylix scheme on rebuild.
  themeQml = ''
    // Generated from stylix (config.lib.stylix.colors) — do not edit by hand.
    // Change the active scheme via host variables / palettes.nix.
    import QtQuick

    QtObject {
        readonly property color base00: "#${c.base00}" // background
        readonly property color base01: "#${c.base01}" // lighter background
        readonly property color base02: "#${c.base02}" // selection background
        readonly property color base03: "#${c.base03}" // comments
        readonly property color base04: "#${c.base04}" // dark foreground
        readonly property color base05: "#${c.base05}" // foreground
        readonly property color base06: "#${c.base06}" // light foreground
        readonly property color base07: "#${c.base07}" // light background
        readonly property color base08: "#${c.base08}" // red
        readonly property color base09: "#${c.base09}" // orange
        readonly property color base0A: "#${c.base0A}" // yellow
        readonly property color base0B: "#${c.base0B}" // green
        readonly property color base0C: "#${c.base0C}" // cyan
        readonly property color base0D: "#${c.base0D}" // blue
        readonly property color base0E: "#${c.base0E}" // magenta
        readonly property color base0F: "#${c.base0F}" // brown
        readonly property color accent: "#${config.variables.accent0}"
    }
  '';
in {
  home.packages = [inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default];

  xdg.configFile = {
    # Generated palette (pure, store-only — palette is Nix-driven by design).
    "quickshell/Theme.qml".text = themeQml;
    # Native shell entrypoint: symlinked to the working tree in designMode for
    # live QML reload, else the in-store copy.
    "quickshell/shell.qml".source = mkDesignSource {
      repo = "modules/home/quickshell/shell.qml";
      store = ./shell.qml;
    };
  };
}
