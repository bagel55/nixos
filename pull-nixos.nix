{ config, pkgs, ... }:

let
  sshPath = "${pkgs.openssh}/bin/ssh";
  gitPath = "${pkgs.git}/bin/git";
in {
  systemd.services.git-pull-on-boot = {
  description = "Fetch and pull latest NixOS config on boot";
  wantedBy = [ "multi-user.target" ];
  after = [ "network-online.target" "NetworkManager-wait-online.service" ];
  requires = [ "network-online.target" "NetworkManager-wait-online.service" ];

  serviceConfig = {
    Type = "oneshot";
    Environment = ''
      GIT_SSH_COMMAND=${sshPath} -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes
      PATH=/run/current-system/sw/bin:/usr/bin:/bin
    '';
    ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
    ExecStart = pkgs.writeShellScript "git-pull-on-boot" ''
      set -e
      LOGFILE="/home/bagel/git-pull-on-boot.log"

      echo "[INFO] Starting git fetch + pull at $(date)" >> "$LOGFILE" 2>&1
      cd /etc/nixos

      echo "RESOLV CONF:"
      cat /etc/resolv.conf >> "$LOGFILE" 2>&1

      ${gitPath} fetch origin main >> "$LOGFILE" 2>&1
      ${gitPath} reset --hard origin/main >> "$LOGFILE" 2>&1

      echo "[INFO] Git fetch + pull complete" >> "$LOGFILE" 2>&1
    '';
    User = "root";
    RemainAfterExit = true;
  };
};

}

