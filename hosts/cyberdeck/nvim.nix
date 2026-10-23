{
  pkgs,
  username,
  ...
}: {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    extraPackages = [pkgs.claude-code];

    lazy.plugins."claudecode.nvim" = {
      package = pkgs.vimPlugins.claudecode-nvim;
      setupModule = "claudecode";
      setupOpts = {};
      cmd = [
        "ClaudeCode"
        "ClaudeCodeFocus"
        "ClaudeCodeSelectModel"
        "ClaudeCodeAdd"
        "ClaudeCodeSend"
        "ClaudeCodeTreeAdd"
        "ClaudeCodeStatus"
        "ClaudeCodeStart"
        "ClaudeCodeStop"
        "ClaudeCodeOpen"
        "ClaudeCodeClose"
        "ClaudeCodeDiffAccept"
        "ClaudeCodeDiffDeny"
        "ClaudeCodeCloseAllDiffs"
      ];
      keys = [
        {
          mode = "n";
          key = "<leader>ac";
          action = "<cmd>ClaudeCode<cr>";
          desc = "Toggle Claude";
        }
        {
          mode = "n";
          key = "<leader>af";
          action = "<cmd>ClaudeCodeFocus<cr>";
          desc = "Focus Claude";
        }
        {
          mode = "n";
          key = "<leader>ar";
          action = "<cmd>ClaudeCode --resume<cr>";
          desc = "Resume Claude";
        }
        {
          mode = "n";
          key = "<leader>aC";
          action = "<cmd>ClaudeCode --continue<cr>";
          desc = "Continue Claude";
        }
        {
          mode = "n";
          key = "<leader>am";
          action = "<cmd>ClaudeCodeSelectModel<cr>";
          desc = "Select Claude model";
        }
        {
          mode = "n";
          key = "<leader>ab";
          action = "<cmd>ClaudeCodeAdd %<cr>";
          desc = "Add current buffer";
        }
        {
          mode = "v";
          key = "<leader>as";
          action = "<cmd>ClaudeCodeSend<cr>";
          desc = "Send to Claude";
        }
        {
          mode = "n";
          key = "<leader>aa";
          action = "<cmd>ClaudeCodeDiffAccept<cr>";
          desc = "Accept diff";
        }
        {
          mode = "n";
          key = "<leader>ad";
          action = "<cmd>ClaudeCodeDiffDeny<cr>";
          desc = "Deny diff";
        }
      ];
    };
  };
}
