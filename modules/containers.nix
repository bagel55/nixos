{ config, pkgs, lib, ... }:{
  virtualisation.podman.enable = true;

  virtualisation.oci-containers.containers.tor-browser = {
    image = "ghcr.io/pariseed/podman-torbrowser:latest";
    extraOptions = [
      "--rm"
      "--ipc=host"
      "--userns=keep-id"
    ];
    volumes = [
      "/run/user/1000/wayland-0:/run/user/1000/wayland-0"
      "/home/youruser/.Xauthority:/home/youruser/.Xauthority:ro"
    ];
    environment = {
      WAYLAND_DISPLAY = "wayland-0";
    };
    autoStart = false;
  };
}
