{pkgs, ...}: {
  programs.nvf.settings.vim.lazy.plugins = {
    "Coqtail" = {
      enabled = true;
      package = pkgs.vimPlugins.Coqtail;
      lazy = false;
      ft = "v";
      after = ''
        vim.g.coqtail_map_prefix = "<localleader>c"
      '';
    };
  };
}
