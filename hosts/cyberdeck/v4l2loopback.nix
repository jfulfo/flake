{
  config,
  lib,
  ...
}: {
  boot.extraModulePackages = lib.mkForce [
    (config.boot.kernelPackages.v4l2loopback.overrideAttrs (old: {
      postInstall =
        (old.postInstall or "")
        + ''
          rm -f $out/lib/modules/*/modules.*
        '';
    }))
  ];
}
