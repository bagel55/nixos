{ config, pkgs, ... }:{
containers.tor-browser = {
  autoStart = true;
  privateNetwork = true;

  config = { config, pkgs, ... }: {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 9050 ];
      extraCommands = ''
        iptables -A OUTPUT -m owner --uid-owner toruser -j ACCEPT
        iptables -P OUTPUT DROP
      '';
    };
    services.xserver.enable = false;

    environment.systemPackages = with pkgs; [
      tor-browser-bundle-bin
      xclip
    ];

    users.users.toruser = {
      isNormalUser = true;
      password = "tor";
    };

    system.stateVersion = "23.11";
  };
};
}