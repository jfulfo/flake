{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
    firefox-unwrapped
    ungoogled-chromium
  ];
}
