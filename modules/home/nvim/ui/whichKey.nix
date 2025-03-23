{
  programs.nvf.settings.vim.binds.whichKey = {
    enable = true;
    setupOpts = {
      #preset = "classic";
      win.border = "none";
      icons = {
        separator = "";
        rules = false;
        group = "";
      };
    };
    register = {
      "<leader>b" = "󰓩  [B]uffers";
      "<leader>c" = "  Git [C]onflict";
      "<leader>d" = "  [D]ebug";
      "<leader>f" = "󰭎  [F]ind (Telescope)";
      "<leader>h" = "󰊢  Git [H]unk";
      "<leader>l" = "  [L]SP";
      "<leader>t" = "  [T]oggle";
      "<leader>v" = "  [V]isual";
      "<leader>x" = "  Trouble";

      "<leader>tt" = "  [T]oggle [T]erminal";
      "<leader>tc" = "  [T]oggle [C]omment";

      # latex
      "<localleader>l" = " [L]aTeX";
      # coq
      "<localleader>c" = "  [C]oq";
    };
  };
}
