{
  lib,
  config,
  host,
  ...
}: let
  inherit (config.variables) intelID nvidiaID;
in {
  imports = [
    ../../hosts/${host}
    ../../modules/drivers
    ../../modules/core
  ];

  # Nvidia Prime offload needs both bus IDs; they have no sensible default, so
  # this profile requires the host to supply them (ADR-0003).
  assertions = [
    {
      assertion = intelID != null && nvidiaID != null;
      message = "profiles/nvidia-laptop requires intelID and nvidiaID in the host's variables.nix (Nvidia Prime bus IDs).";
    }
  ];

  # Enable GPU Drivers
  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = true;
    # mkIf guards the null case so the assertion above is the error the user
    # sees, not a null-vs-str type crash.
    intelBusID = lib.mkIf (intelID != null) intelID;
    nvidiaBusID = lib.mkIf (nvidiaID != null) nvidiaID;
  };
  drivers.intel.enable = false;
  vm.guest-services.enable = false;
}
