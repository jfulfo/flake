{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    # basic config

    enable = true;

    settings.vim = {
      extraPackages = with pkgs; [
        fd
        fzf
        git
        ripgrep
        zoxide
        coq_8_18
        coqPackages_8_18.coq-lsp
        coqPackages_8_18.stdlib
        coqPackages_8_18.mathcomp-ssreflect
        coqPackages_8_18.MenhirLib
      ];
      python3Packages = [
        "pynvim"
      ];

      vimAlias = true;
      viAlias = true;
      withNodeJs = true;
      withPython3 = true;

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

      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
      };

      # specific package configs

      autopairs.nvim-autopairs.enable = true;

      autocomplete.nvim-cmp = {
        enable = true;
      };

      comments.comment-nvim.enable = true;

      dashboard.dashboard-nvim.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      lsp = {
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = true;
        otter-nvim.enable = true;
        nvim-docs-view.enable = false;
        lspconfig.enable = true;
      };

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

      projects.project-nvim.enable = true;

      statusline = {
        lualine = {
          enable = true;
          theme = lib.mkForce "catppuccin";
        };
      };

      session = {
        nvim-session-manager.enable = false;
      };

      snippets.luasnip.enable = true;

      tabline = {
        nvimBufferline.enable = true;
      };

      terminal.toggleterm = {
        enable = true;
      };

      treesitter = {
        enable = true;
        autotagHtml = true;
        context.enable = true;
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

      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;

        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };
    };
  };
}
