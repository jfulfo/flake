{ ... }:

{
  virtualisation.libvirtd.enable = true;
  # rootless: membership in the docker group is root-equivalent
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
