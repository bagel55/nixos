{ config, pkgs, lib, ... }:
let
  uid = builtins.getEnv "UID";
in {
  home.packages = [ pkgs.podman ];
  services.podman.enable = true;

  services.podman.containers.tor-browser = {
    image = "docker.io/raparicio/torbrowser:latest";
    description = "Tor Browser in Podman";
    autoStart = true;
    extraConfig = {
      Run = {
        Args = lib.mkForce [
          "--env" "WAYLAND_DISPLAY"
          "--env" "XDG_RUNTIME_DIR"
          "--volume" "/run/user/${toString uid}/wayland-0:/run/user/${toString uid}/wayland-0"
          "--device" "/dev/dri"
          "--network" "none"
          "--read-only"
          "--tmpfs" "/tmp"
          "--user" (toString uid)
          "--name" "tor-browser"
        ];
      };
    };
  };

  xdg.desktopEntries.tor-browser = {
    name = "Tor Browser";
    exec = "podman run --rm --podman-wait tor-browser";
    icon = "/run/current-system/sw/share/icons/hicolor/128x128/apps/torbrowser.png";
    terminal = false;
    categories = [ "Network" "WebBrowser" ];
  };
}
