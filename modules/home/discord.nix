{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    vesktop
  ];

  home.file = {
    ".config/vesktop/settings/quickCss.css" = {
      # source = config.lib.file.mkOutOfStoreSymlink ./quickCss.css;
      text = ''
        :root {
          font-family: var(--font, '${config.stylix.fonts.monospace.name}'), '${config.stylix.fonts.monospace.name}';
          font-primary: var(--font, '${config.stylix.fonts.monospace.name}'), '${config.stylix.fonts.monospace.name}';
          font-display: var(--font, '${config.stylix.fonts.monospace.name}'), '${config.stylix.fonts.monospace.name}';
        }
      '';
      executable = false;
    };
  };
}
