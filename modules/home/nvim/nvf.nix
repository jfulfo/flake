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
      additionalRuntimePaths = [
        ./nvim-custom
      ];
    };
  };
}
