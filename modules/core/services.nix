{
  config,
  pkgs,
  ...
}: {
  # Services to start
  services = {
    blueman.enable = true;
    flatpak.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    joycond.enable = config.variables.gaming;
    libinput.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    # wireguard mesh between hosts; `sudo tailscale up` once per machine
    tailscale = {
      enable = true;
      openFirewall = true;
    };
    resolved.enable = true;

    smartd = {
      enable = false;
      autodetect = true;
    };
    printing = {
      enable = true;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  # `flatpak remote-add` fetches the .flatpakrepo over the network even when the
  # remote already exists, so this unit needs working DNS. With no ordering it
  # raced NetworkManager at boot, and during `switch-to-configuration` it runs
  # while NetworkManager is being restarted underneath it — network-online.target
  # is already active there, so After= alone does not help, hence the retry.
  # A transient network blip must not fail a whole system activation, so give up
  # quietly after a few tries; the unit runs again on the next boot.
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    wants = ["network-online.target"];
    after = ["network-online.target"];
    path = [pkgs.flatpak];
    serviceConfig.Type = "oneshot";
    script = ''
      for attempt in 1 2 3 4 5; do
        if flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; then
          exit 0
        fi
        echo "flatpak-repo: attempt $attempt could not reach flathub, retrying in 5s" >&2
        sleep 5
      done
      echo "flatpak-repo: giving up; flathub will be registered on the next boot" >&2
    '';
  };
}
