{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nodejs
    obs-studio
  ];
}
