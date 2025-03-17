{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = with pkgs.vimPlugins; {
    vimtex = {
      package = vimtex;
      after = ''
        filetype plugin indent on
        syntax enable
        let g:tex_flavor = 'latex'
        let g:vimtex_view_method = 'zathura'
        let g:vimtex_quickfix_mode = 0
        let g:conceallevel = 1
        let g:tex_conceal = 'abdmg'
      '';
    };
  };
}
