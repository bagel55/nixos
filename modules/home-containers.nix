{ config, pkgs, lib, ... }:

let
  torImage = "docker.io/domistyle/tor-browser:latest";
in {
  services.podman.enable = true;

  systemd.user.services.podman-tor = {
    Unit = {
      Description = "Tor Browser (VNC) Container";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      Restart = "on-failure";
      ExecStart = "${pkgs.podman}/bin/podman run --rm -p 5800:5800 ${torImage}";
      ExecStop = "${pkgs.podman}/bin/podman stop tor-browser";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  xdg.desktopEntries.tor-browser = {
    name = "Tor Browser (Podman VNC)";
    exec = "systemctl --user start podman-tor";
    icon = "tor-browser";
    terminal = false;
    type = "Application";
    categories = [ "Network" "X-Privacy" ];
    startupNotify = false;
  };
}
