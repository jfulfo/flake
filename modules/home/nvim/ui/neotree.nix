{
  programs.nvf.settings.vim = {
    filetree = {
      neo-tree = {
        enable = true;
        setupOpts = {
          git_status_async = true;
          sources = ["filesystem" "buffers" "git_status"];
          enable_diagnostics = true;
          enable_refresh_on_write = true;
          source_selector = {
            winbar = true;
            content_layout = "center";
            sources = [
              {
                source = "filesystem";
                display_name = " Files";
              }
              {
                source = "buffers";
                display_name = "󰈙 Bufs";
              }
              {
                source = "git_status";
                display_name = "󰊢 Git";
              }
              {
                source = "diagnostics";
                display_name = "󰒡 Diagnostic";
              }
            ];
          };
          filesystem = {
            use_libuv_file_watcher = true;
            follow_current_file = {
              enabled = true;
              leave_dirs_open = false;
            };
          };
        };
      };
    };
    maps.normal = {
      "<C-n>" = {
        silent = true;
        noremap = true;
        action = "<cmd>Neotree toggle<CR>";
        desc = "Toggle neotree";
      };
    };
  };
}
