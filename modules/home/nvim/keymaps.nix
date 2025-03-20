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
