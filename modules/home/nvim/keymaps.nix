{
  programs.nvf.settings.vim = {
    keymaps = [
      # window navigation
      {
        key = "<C-left>";
        mode = ["n"];
        action = "<C-w><C-h>";
        desc = "Move focus to the left window";
      }
      {
        key = "<C-right>";
        mode = ["n"];
        action = "<C-w><C-l>";
        desc = "Move focus to the right window";
      }
      {
        key = "<C-down>";
        mode = ["n"];
        action = "<C-w><C-j>";
        desc = "Move focus to the lower window";
      }
      {
        key = "<C-up>";
        mode = ["n"];
        action = "<C-w><C-k>";
        desc = "Move focus to the upper window";
      }
      {
        key = "<enter>";
        mode = ["n"];
        action = "<cmd>HopWord<cr>";
        desc = "Hop for words";
        silent = true;
      }
    ];
  };
}
