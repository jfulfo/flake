{pkgs, ...}: {
  # TODO: eval whether haskell-tools.nvim is worthwhile.
  /*
     programs.nvf.settings.vim.lazy.plugins = {
    "haskell-tools.nvim" = {
      enabled = true;
      package = pkgs.vimPlugins.haskell-tools-nvim;
      lazy = true;
      ft = "v";
      after = ''
      '';
    };
  };
  */
  programs.nvf.settings.vim = {
    languages.haskell = {
      enable = true;
      dap.enable = false;
      lsp.enable = true;
      treesitter.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; {
      agda-vim = {
        package = agda-vim;
        #setup = ''        '';
      };
    };
    lazy.plugins = {
      "cornelis" = {
        enabled = true;
        package = pkgs.vimPlugins.cornelis;
        lazy = true;
        ft = "agda";
        after = ''
        '';
      };
    };
  };
}
