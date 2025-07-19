{ config, pkgs, lib, ... }:{
  xdg.desktopEntries.tor-browser = {
    name = "Tor Browser (Podman)";
    exec = "podman start -a tor-browser";
    icon = "tor-browser"; # optional: path to an icon if needed
    terminal = false;
    type = "Application";
    categories = [ "Network" "X-Privacy" ];
  };
}
