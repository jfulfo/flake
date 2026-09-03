{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.drivers.nvidia;
in
{
  options.drivers.nvidia = {
    enable = mkEnableOption "Enable Nvidia Drivers";
  };

  config = mkIf cfg.enable {
    # nixpkgs lc0 hard-disables cuda (-Dplain_cuda=false, no cudaSupport knob),
    # so rebuild it with the cuda backend on nvidia hosts. native_cuda stays
    # false: the sandbox has no GPU, so nvcc falls back to -arch=all-major.
    # cudnn_include/cudnn_libdirs are lc0's option names for plain cuda paths
    # too; nvcc's kernel compiles only see -I flags from cudnn_include.
    nixpkgs.overlays = [
      (final: prev: {
        lc0 = prev.lc0.overrideAttrs (old: {
          nativeBuildInputs =
            old.nativeBuildInputs
            ++ [
              final.cudaPackages.cuda_nvcc
              final.autoAddDriverRunpath
            ];
          buildInputs =
            old.buildInputs
            ++ [
              final.cudaPackages.cuda_cudart
              final.cudaPackages.libcublas
            ];
          mesonFlags =
            lib.remove "-Dplain_cuda=false" old.mesonFlags
            ++ [
              "-Dplain_cuda=true"
              # nvcc's include dir carries crt/host_defines.h, which cudart's
              # headers include but strictDeps hides from g++.
              "-Dcudnn_include=${lib.getOutput "include" final.cudaPackages.cuda_cudart}/include,${lib.getOutput "include" final.cudaPackages.libcublas}/include,${final.cudaPackages.cuda_nvcc}/include"
              "-Dcudnn_libdirs=${lib.getLib final.cudaPackages.cuda_cudart}/lib,${lib.getLib final.cudaPackages.libcublas}/lib"
            ];
        });
      })
    ];

    # Session env for nvidia. These used to be set unconditionally in
    # modules/home/hyprland/config.lua, which is shared by every profile, so the
    # amd host was also told to load the nvidia VA-API driver: `vainfo` failed
    # with va_openDriver() returning -1 and all video decode fell back to
    # software. Gated on drivers.nvidia.enable, they only reach nvidia hosts.
    # (WLR_NO_HARDWARE_CURSORS / WLR_DRM_NO_ATOMIC are deliberately not carried
    # over: hyprland replaced wlroots with aquamarine in 0.41 and ignores both.
    # The equivalent is the `cursor:no_hardware_cursors` config option.)
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_VRR_ALLOWED = "1";
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;
      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = false;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;
      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;
      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
