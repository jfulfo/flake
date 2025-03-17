{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;

    settings.vim = {
      extraPackages = with pkgs; [
        git
        fzf
        ripgrep
        fd
        zoxide
        coq_8_18
        coqPackages_8_18.coq-lsp
        coqPackages_8_18.stdlib
        coqPackages_8_18.mathcomp-ssreflect
        coqPackages_8_18.MenhirLib
      ];

      vimAlias = true;
      viAlias = true;
      withNodeJs = true;

      options = {
        tabstop = 2;
        shiftwidth = 2;
        wrap = false;
      };

      theme = {
        enable = true;
        name = lib.mkForce "catppuccin";
        style = "mocha";
        transparent = lib.mkForce true;
      };

      spellcheck = {
        enable = false;
      };

      lsp = {
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = true;
        otter-nvim.enable = true;
        lsplines.enable = false;
        nvim-docs-view.enable = false;
        lspconfig.enable = true;
      };

      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;

        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };

      statusline = {
        lualine = {
          enable = true;
          theme = lib.mkForce "catppuccin";
        };
      };

      autopairs.nvim-autopairs.enable = true;
      autocomplete.nvim-cmp = {
        enable = true;
        mappings = {
          confirm = "<C-y>";
        };
      };
      snippets.luasnip.enable = true;

      tabline = {
        nvimBufferline.enable = true;
      };

      treesitter.context.enable = true;

      git = {
        enable = true;
        git-conflict.enable = false;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      projects.project-nvim.enable = true;
      dashboard.dashboard-nvim.enable = true;

      notes = {
        todo-comments = {
          enable = true;
          setupOpts = {
            signs = true;
          };
        };
      };

      notify = {
        nvim-notify.enable = false;
        # nvim-notify.setupOpts.background_colour = "#${config.lib.stylix.colors.base01}";
      };

      utility = {
        ccc.enable = false;
        vim-wakatime.enable = false;
        icon-picker.enable = true;
        surround.enable = true;
        diffview-nvim.enable = true;
        motion = {
          hop = {
            enable = true;
            mappings.hop = null;
          };
          leap.enable = false;
          precognition.enable = false;
        };

        images.image-nvim = {
          enable = false;
          setupOpts = {
            backend = "kitty";
          };
        };
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        illuminate.enable = true;
        breadcrumbs = {
          enable = false;
          navbuddy.enable = false;
        };
        smartcolumn = {
          enable = false;
        };
        fastaction.enable = true;
      };

      session = {
        nvim-session-manager.enable = false;
      };

      comments = {
        comment-nvim = {
          enable = true;
          mappings = {
            toggleCurrentLine = "<leader>tcc";
            toggleCurrentBlock = "<leader>tbc";
            toggleOpLeaderLine = "<leader>tc";
            toggleOpLeaderBlock = "<leader>tb";
            toggleSelectedLine = "<leader>tc";
            toggleSelectedBlock = "<leader>tb";
          };
        };
      };
    };
  };
}
