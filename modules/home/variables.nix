# modules/home/variables.nix
{
  lib,
  systemVariables ? {},
  ...
}: {
  options.variables = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "Host-specific variables in Home Manager";
  };

  config.variables = systemVariables;
}
