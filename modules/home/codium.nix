{
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    # TODO: fix the bug where codium fails to display
    enable = true;
    package = pkgs.vscode-fhs;

    # stylix derives every vscode size from fontSizes.terminal (18pt * 4/3 =
    # 24px), which is right for the integrated terminal but too large for the
    # editor. Override just the editor here rather than lowering
    # fontSizes.terminal, which also drives kitty/ghostty/foot.
    # mkForce is required: stylix writes these same keys.
    profiles.default.userSettings = {
      "editor.fontSize" = lib.mkForce 18.0;
      # These two exist only to track editor.fontSize; stylix scales them from
      # vscode's defaults (9/14 and 13/14 of the default editor size), so they
      # are rescaled to keep the same ratio against 18 instead of 24.
      "editor.minimap.sectionHeaderFontSize" = lib.mkForce (18.0 * 9.0 / 14.0);
      "scm.inputFontSize" = lib.mkForce (18.0 * 13.0 / 14.0);
    };
  };
}
