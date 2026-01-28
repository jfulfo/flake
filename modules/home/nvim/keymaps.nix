{
  programs.nvf.settings.vim = {
    keymaps = [
      # window navigation
      {
        key = "<C-left>";
        mode = ["n"];
        action = "<C-w><C-h>";
        desc = "Move focus to the left window";
        silent = true;
      }
      {
        key = "<C-right>";
        mode = ["n"];
        action = "<C-w><C-l>";
        desc = "Move focus to the right window";
        silent = true;
      }
      {
        key = "<C-down>";
        mode = ["n"];
        action = "<C-w><C-j>";
        desc = "Move focus to the lower window";
        silent = true;
      }
      {
        key = "<C-up>";
        mode = ["n"];
        action = "<C-w><C-k>";
        desc = "Move focus to the upper window";
        silent = true;
      }
      {
        key = "<enter>";
        mode = ["n"];
        action = "<cmd>HopWord<cr>";
        desc = "Hop for words";
        silent = true;
      }

      {
        key = "<Esc>";
        mode = ["n"];
        action = "<cmd>nohlsearch<CR>";
        desc = "Clear search highlights";
        silent = true;
      }
      {
        key = "<Esc><Esc>";
        mode = ["t"];
        action = "<C-\\><C-n>";
        desc = "Exit terminal mode";
        silent = true;
      }

      # goto defn./decl.
      {
        key = "gd";
        mode = ["n"];
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        desc = "goto definition";
      }
      {
        key = "gD";
        mode = ["n"];
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        desc = "goto declaration";
      }

      # close a buffer
      {
        key = "<leader>bd";
        mode = ["n"];
        action = "<cmd>bp | bd#<CR>";
        desc = "buffer delete";
      }

      # rename symbol
      {
        key = "<leader>lr";
        mode = ["n"];
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        desc = "rename symbol";
      }
    ];

    autocomplete.nvim-cmp.mappings = {
      confirm = "<C-y>";
    };
    comments.comment-nvim.mappings = {
      toggleCurrentLine = "<leader>tcc";
      toggleCurrentBlock = "<leader>tcb";

      toggleOpLeaderLine = "<leader>tcC";
      toggleOpLeaderBlock = "<leader>tcB";
      toggleSelectedLine = "<leader>tcC";
      toggleSelectedBlock = "<leader>tcB";
    };
    terminal.toggleterm.mappings = {
      open = "<C-t>";
    };
  };
}
