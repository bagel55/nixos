# nixos/modules/containers.nix
{ config, pkgs, lib, ... }:

{
  # Just enable podman globally; no container definitions here
  virtualisation.podman.enable = true;

  # Ensure podman rootless works correctly
  systemd.user.extraConfig = ''
    DefaultEnvironment="PATH=/run/current-system/sw/bin:/run/wrappers/bin"
  '';
}
