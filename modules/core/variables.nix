{
  config,
  lib,
  host,
  ...
}: let
  hostVariables = import ../../hosts/${host}/variables.nix;
in {
  # this is where variables from `hosts/${host}/variables.nix` get processed
  # and added to the configuration for other modules to reference.
  options.variables = lib.mkOption {
    description = "host-specific variables";
    type = lib.types.attrs;
    default = {};
  };

  config.variables = hostVariables;
}
