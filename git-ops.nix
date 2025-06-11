{ config, pkgs, ... }:

let
  sshPath = "${pkgs.openssh}/bin/ssh";
  gitPath = "${pkgs.git}/bin/git";
  nixEnv = "${pkgs.nix}/bin/nix-env";
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
      rm -f /etc/nixos/debug/git-pull-on-boot.log
      LOGFILE="/etc/nixos/debug/git-pull-on-boot.log"

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

system.activationScripts.push-nixos = {
  text = ''
    echo "Running post-rebuild Git push..."

    export GIT_SSH_COMMAND="${sshPath} -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes"
    export PATH=/run/current-system/sw/bin:/usr/bin:/bin

    cd /etc/nixos || exit 1

    ${gitPath} config user.name "bagel"
    ${gitPath} config user.email "bagel2255@protonmail.com"

    ${gitPath} add .
    ${gitPath} commit -m "Auto backup on $(date '+%Y-%m-%d %H:%M:%S')" || true
    ${gitPath} push origin main
  '';
};

system.activationScripts.gc-keep-last-5 = {
  text = ''
    echo "[GC] Deleting all but the last 5 generations..."
    ${nixEnv} --delete-generations +5 --profile /nix/var/nix/profiles/system
  '';
};
}
