{
  programs.nvf.settings.vim.languages.markdown = {
    enable = true;
    format = {
      enable = true;
      extraFiletypes = ["mdx"];
    };
    lsp.enable = true;
    treesitter.enable = true;
    extensions.render-markdown-nvim.enable = true;
  };
}
