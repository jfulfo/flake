{config, ...}: let
  inherit (config.variables) keyboardLayout keyboardVariant;
in {
  services.xserver = {
    enable = false;
    xkb = {
      layout = "${keyboardLayout}";
      variant = "${keyboardVariant}";
    };
  };
}
