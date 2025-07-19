# home-containers.nix
{ config, pkgs, lib, ... }:

let
  torImage = "ghcr.io/pariseed/podman-torbrowser:latest";
in {

  services.podman.enable = true;

  systemd.user.services.podman-tor = {
  Unit = {
    Description = "Tor Browser (Podman Wayland)";
    After = [ "graphical-session.target" ];
  };
  Service = {
    Type = "oneshot";
    RemainAfterExit = true;
    Environment = "XDG_RUNTIME_DIR=/run/user/1000";
    ExecStart = ''
      ${pkgs.podman}/bin/podman run --rm \
        --userns=keep-id \
        --ipc=host \
        -v ${config.home.homeDirectory}/.Xauthority:/home/user/.Xauthority:ro \
        -v $XDG_RUNTIME_DIR/wayland-0:/run/user/$(id -u)/wayland-0 \
        -e WAYLAND_DISPLAY=wayland-0 \
        ghcr.io/pariseed/podman-torbrowser:latest
    '';
  };
  Install = {
    WantedBy = [ "default.target" ];
  };
};

  xdg.desktopEntries.tor-browser = {
    name = "Tor Browser (Podman)";
    exec = "systemctl --user start podman-tor";
    icon = "tor-browser";
    terminal = false;
    type = "Application";
    categories = [ "Network" "X-Privacy" ];
    startupNotify = false;
  };
}
