{
  pkgs,
  host,
  options,
  ...
}: {
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        8080
      ];
      allowedUDPPorts = [
        59010
        59011
      ];
    };
    extraHosts = ''
      127.0.0.1 lmlicenses.wip4.adobe.com
      127.0.0.1 lm.licenses.adobe.com
      127.0.0.1 na1r.services.adobe.com
      127.0.0.1 hlrcv.stage.adobe.com
      127.0.0.1 practivate.adobe.com 
      127.0.0.1 activate.adobe.com
    '';
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
