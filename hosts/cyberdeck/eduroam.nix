{config, ...}: {
  # Host-specific secrets and the network profile that consumes them. This lives
  # under hosts/ rather than modules/core because every host imports modules/core:
  # declaring the secret there makes kamakiri/laptop2/vm try to decrypt a file
  # they are not recipients of, which fails activation. See .sops.yaml.
  sops = {
    secrets."eduroam/private-key-password" = {};

    # NetworkManager substitutes env vars into its declarative profiles with
    # envsubst, so the secret has to reach it as an environment file rather than
    # a bare value. Rendered to /run/secrets/rendered, root-only.
    templates."eduroam.env".content = ''
      EDUROAM_PRIVATE_KEY_PASSWORD=${config.sops.placeholder."eduroam/private-key-password"}
    '';
  };

  networking = {
    networkmanager.ensureProfiles.environmentFiles = [config.sops.templates."eduroam.env".path];
    networkmanager.ensureProfiles.profiles = {
      eduroam = {
        connection = {
          id = "IllinoisNet";
          type = "wifi";
          interface-name = "wlp194s0"; ## replace with your interface-name as displayed by "ip a"
        };
        wifi = {
          mode = "infrastructure";
          ssid = "IllinoisNet";
        };
        wifi-security = {
          key-mgmt = "wpa-eap"; ## adapt according to your universities setup
          pmf = "1";
        };
        "802-1x" = {
          ## not all or even some additional values may be needed here according to your institution
          eap = "tls"; ## adapt according to your universities setup
          identity = "jamiehf2@illinois.edu";
          client-cert = "/etc/ssl/certs/eduroam/jamiehf2@illinois.edu.pem";
          private-key = "/etc/wpa_supplicant/jamiehf2@illinois.edu.key";
          # substituted by NetworkManager via envsubst from sops.templates."eduroam.env";
          # see modules/core/sops.nix. Never put the literal here: ensureProfiles
          # renders each profile into a world-readable /nix/store file.
          private-key-password = "$EDUROAM_PRIVATE_KEY_PASSWORD";
          private-key-password-flags = 0;
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          method = "auto";
        };
      };
    };
  };
}
