# modules/home/variables.nix
{
  lib,
  systemVariables ? {},
  ...
}: {
  options.variables = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "host-specific variables in home manager";
  };

  config.variables = systemVariables;
}
