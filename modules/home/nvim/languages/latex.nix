{pkgs, ...}: {
  programs.nvf.settings.vim.lazy.plugins = {
    vimtex = {
      enabled = true;
      package = pkgs.vimPlugins.vimtex;
      lazy = true;
      ft = "tex";
      after = ''
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_mode = 0
        vim.g.conceallevel = 2
        vim.g.tex_conceal = "abdmg"
        vim.g.vimtexd_view_forward_search_on_start = false
        vim.api.nvim_command('unlet b:did_ftplugin')
        vim.api.nvim_command('call vimtex#init()')
      '';
    };
  };
}
