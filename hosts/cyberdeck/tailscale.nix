{username, ...}: {
  services.tailscale = {
    useRoutingFeatures = "client";
    extraSetFlags = ["--operator=${username}"];
    disableUpstreamLogging = true;
  };
}
