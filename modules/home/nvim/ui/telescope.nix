{pkgs, ...}: {
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;
      setupOpts = {
        defaults = {
          vimgrep_arguments = [
            "${pkgs.ripgrep}/bin/rg"
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
            "--hidden"
            "--no-ignore"
            "--fixed-strings"
          ];
          mappings = {
            i = {
              "<esc>" = "close";
            };
          };
        };
        extensions = {
          fzf = {
            fuzzy = true;
            override_generic_sorter = true;
            override_file_sorter = true;
            case_mode = "smart_case";
          };
          zoxide = {
            prompt_title = "Change directory";
          };
        };
      };
      mappings = {
        buffers = "<leader>fb";
        findFiles = "<leader>ff";
        gitBranches = null;
        gitStatus = null;
        liveGrep = "<leader>fg";
      };
    };
    keymaps = [
      {
        key = "<leader>fz";
        mode = ["n"];
        action = ":Telescope zoxide list<CR>";
        silent = true;
        desc = "Change directory using zoxide";
      }
    ];
    luaConfigRC.telescope =
      # lua
      ''
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('zoxide')
      '';
    extraPlugins = {
      telescope-fzf-nvim = {
        package = pkgs.vimPlugins.telescope-fzf-native-nvim;
      };
      telescope-zoxide = {
        package = pkgs.vimPlugins.telescope-zoxide;
      };
    };
  };
}
