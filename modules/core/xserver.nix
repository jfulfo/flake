{config, ...}: let
  inherit (config.variables) keyboardLayout;
in {
  services.xserver = {
    enable = false;
    xkb = {
      layout = "${keyboardLayout}";
      variant = "";
    };
  };
}
