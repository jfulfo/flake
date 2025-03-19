{lib, ...}: {
  qt = {
    enable = true;
    # style.name = lib.mkForce "adwaita-dark";
    platformTheme.name = lib.mkForce "gtk3";
  };
}
