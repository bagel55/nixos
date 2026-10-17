{ pkgs, ... }:
let
  # Shared rebuild step: rebuild this machine (flake output = hostname),
  # hide routine noise from nixos-rebuild / os-prober, then list what changed.
  rebuild = ''
    repo=/etc/nixos
    host=$(cat /proc/sys/kernel/hostname)
    old=$(readlink -f /run/current-system)

    # Lines that show up on every rebuild and say nothing useful.
    noise='^lsblk: /dev/mapper/|os-prober will be executed|Its output will be used to detect bootable|^Checking switch inhibitors|^setting up /etc|^reloading user units|^restarting the following user units|^restarting sysinit-reactivation|^\[Permissions\]|^\[INFO\] Triggering git-push|^Done\. The new configuration is'

    echo ":: Rebuilding $host"
    set +o errexit
    sudo nixos-rebuild switch --flake "$repo#$host" 2>&1 | grep --line-buffered -vE "$noise"
    status=''${PIPESTATUS[0]}
    set -o errexit
    if [ "$status" -ne 0 ]; then
      echo ":: Rebuild FAILED (exit $status)"
      exit "$status"
    fi

    echo ":: What changed"
    nvd diff "$old" /run/current-system | grep -vE '^(<<<|>>>) ' || true
  '';

  # `update` from any directory: pull config, update flake inputs, rebuild.
  # The git-push-on-rebuild service then commits and pushes the new flake.lock.
  update = pkgs.writeShellApplication {
    name = "update";
    runtimeInputs = with pkgs; [ git nix nixos-rebuild nvd gnugrep ];
    text = ''
      echo ":: Pulling config from GitHub"
      sudo git -C /etc/nixos pull --rebase --quiet

      echo ":: Updating flake inputs"
      sudo nix flake update --flake /etc/nixos

      ${rebuild}
    '';
  };

  # `upgrade` from any directory: rebuild this machine from /etc/nixos as-is.
  # No pull, no flake update: local edits are kept, versions stay pinned.
  upgrade = pkgs.writeShellApplication {
    name = "upgrade";
    runtimeInputs = with pkgs; [ nixos-rebuild nvd gnugrep ];
    text = rebuild;
  };
in
{
  environment.systemPackages = [ update upgrade ];
}
