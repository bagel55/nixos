{ pkgs, ... }:
let
  # `update` from any directory:
  #   1. pull the config from GitHub
  #   2. update flake inputs (flake.lock)
  #   3. rebuild this machine (flake output = hostname)
  # The git-push-on-rebuild service then commits and pushes the new flake.lock.
  update = pkgs.writeShellApplication {
    name = "update";
    runtimeInputs = with pkgs; [ git nix nixos-rebuild nvd ];
    text = ''
      repo=/etc/nixos
      host=$(cat /proc/sys/kernel/hostname)
      old=$(readlink -f /run/current-system)

      echo ":: [1/3] Pulling config from GitHub"
      sudo git -C "$repo" pull --rebase

      echo ":: [2/3] Updating flake inputs"
      sudo nix flake update --flake "$repo"

      echo ":: [3/3] Rebuilding $host"
      sudo nixos-rebuild switch --flake "$repo#$host"

      echo ":: What changed"
      nvd diff "$old" /run/current-system
    '';
  };
in
{
  environment.systemPackages = [ update ];
}
