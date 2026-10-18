{username, ...}: {
  # Tailnet: this laptop, the Pi (neuromancer, AdGuard Home DNS) and the desktop (wintermute, Jellyfin).
  # DNS for the tailnet is set in the Tailscale admin console to the Pi, so ad blocking follows the laptop.
  services.tailscale = {
    # lets this laptop use an exit node (e.g. route through home on public wifi)
    useRoutingFeatures = "client";
    # run `tailscale status`/`tailscale set` without sudo
    extraSetFlags = ["--operator=${username}"];
    # don't ship tailscaled logs to log.tailscale.io
    disableUpstreamLogging = true;
  };
}
