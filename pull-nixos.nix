{ config, pkgs, ... }:

let
  sshPath = "${pkgs.openssh}/bin/ssh";
  gitPath = "${pkgs.git}/bin/git";
  nixosRebuild = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
in {
  systemd.services.nixos-git-pull-rebuild = {
    description = "Pull latest NixOS config and rebuild on every boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      Environment = "GIT_SSH_COMMAND=${sshPath} -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes";
      ExecStart = pkgs.writeShellScript "git-pull-nixos-and-rebuild" ''
  set -e

  LOCKFILE="/var/lock/nixos-git-pull.lock"
  LOGFILE="/home/bagel/nixos-git-pull.log"

  # Attempt to acquire lock
  exec 9>"$LOCKFILE"
  if ! flock -n 9; then
    echo "[INFO] Another rebuild is in progress. Exiting." >> "$LOGFILE" 2>&1
    exit 0
  fi

  cd /etc/nixos
  echo "[INFO] Fetching latest changes from origin..." >> "$LOGFILE" 2>&1
  ${gitPath} fetch origin main >> "$LOGFILE" 2>&1
  echo "[INFO] Pulling latest changes and rebuilding NixOS..." >> "$LOGFILE" 2>&1
  ${gitPath} reset --hard origin/main >> "$LOGFILE" 2>&1
  ${nixosRebuild} switch --upgrade >> "$LOGFILE" 2>&1
'';
      User = "root";
    };
  };
}