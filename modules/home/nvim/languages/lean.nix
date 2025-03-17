{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = with pkgs.vimPlugins; {
    lean-nvim = {
      package = lean-nvim;
      setup = ''
        require('lean').setup {
          mappings = true
        }
      '';
    };
  };
}
