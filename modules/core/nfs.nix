{config, ...}: let
  inherit (config.variables) enableNFS;
in {
  services = {
    rpcbind.enable = enableNFS;
    nfs.server.enable = enableNFS;
  };
}
