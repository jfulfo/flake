{inputs, ...}: {
  # The home-manager module, not the bare package: stylix's zen-browser target
  # is guarded on `options.programs ? zen-browser`, so a `home.packages` install
  # makes the whole target expand to nothing and zen stays unthemed. `beta`
  # matches `packages.default`, which is where the `zen-beta` binary comes from.
  # Theming is wired up in ./stylix.nix (targets.zen-browser.profileNames).
  imports = [inputs.zen-browser.homeModules.beta];

  programs.zen-browser.enable = true;

  # alternatives, if zen ever needs replacing:
  # home.packages = with pkgs; [firefox-unwrapped ungoogled-chromium];
}
