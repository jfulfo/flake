{
  programs.nvf.settings.vim = {
    keymaps = [
      # window navigation
      {
        key = "<C-h>";
        mode = ["n"];
        action = "<C-w><C-h>";
        desc = "Move focus to the left window";
        silent = true;
      }
      {
        key = "<C-l>";
        mode = ["n"];
        action = "<C-w><C-l>";
        desc = "Move focus to the right window";
        silent = true;
      }
      {
        key = "<C-j>";
        mode = ["n"];
        action = "<C-w><C-j>";
        desc = "Move focus to the lower window";
        silent = true;
      }
      {
        key = "<C-k>";
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
    treesitter.mappings.incrementalSelection = {
      incrementByNode = "<leader>vn";
      decrementByNode = "<leader>vm";
      incrementByScope = "<leader>vc";
      init = "<leader>vv";
    };
  };
}
