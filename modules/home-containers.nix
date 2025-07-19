{ config, pkgs, lib, ... }: {
home.packages = [ pkgs.tor-browser-bundle-bin ];

  xdg.desktopEntries.tor-browser-container = {
    name = "Tor Browser (Container)";
    comment = "Isolated Tor Browser in NixOS container";
    exec = "/home/bagel/.local/bin/tor-browser-container";
    icon = "torbrowser";
    terminal = false;
    categories = [ "Network" "X-Privacy" ];
  };

  home.file.".local/bin/tor-browser-container".text = ''
    #!/bin/bash
    xhost +local: > /dev/null
    sudo nixos-container run tor-browser -- \
      env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY \
      sudo -u toruser tor-browser &
  '';

  home.file.".local/bin/tor-browser-container".executable = true;
}