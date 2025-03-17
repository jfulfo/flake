{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = with pkgs.vimPlugins; {
    Coqtail = {
      package = Coqtail;
    };
    coq-lsp-nvim = {
      package = coq-lsp-nvim;
      setup = "require('coq-lsp').setup {}";
    };
  };
}
