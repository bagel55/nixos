{ config, pkgs, ... }:
let
  sshPath = "${pkgs.openssh}/bin/ssh";
  gitPath = "${pkgs.git}/bin/git";
  nixEnv = "${pkgs.nix}/bin/nix-env";
  alacarteDir = "/etc/nixos/alacarte";
  userName = "bagel";
  userHome = "/home/${userName}";
in {
systemd.services.git-push-on-rebuild = {
  description = "Push latest NixOS config after rebuild";

  serviceConfig = {
    Type = "oneshot";
    Environment = ''
      GIT_SSH_COMMAND=${sshPath} -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes
      PATH=/run/current-system/sw/bin:/usr/bin:/bin
    '';
    ExecStart = pkgs.writeShellScript "git-push-on-rebuild" ''
      LOGFILE="/etc/nixos/debug/git-push-on-rebuild.log"
      rm -f "$LOGFILE"

      {
        echo "[INFO] Starting Git push at $(date)"
        cd /etc/nixos

        ${gitPath} config user.name "bagel"
        ${gitPath} config user.email "bagel2255@protonmail.com"

        ${gitPath} add .
        ${gitPath} commit -m "Auto backup on $(date '+%Y-%m-%d %H:%M:%S')" || echo "[INFO] Nothing to commit"
        ${gitPath} push origin main || echo "[WARN] Git push failed"

        echo "[INFO] Push complete at $(date)"
      } >> "$LOGFILE" 2>&1
    '';
    User = "root";
    SuccessExitStatus = [ 0 1 ];
    StandardOutput = "journal";
    StandardError = "journal";
  };
};

system.activationScripts.gitPushOnRebuild = {
  text = ''
    echo "[INFO] Triggering git-push-on-rebuild.service"
    /run/current-system/systemd/bin/systemctl start git-push-on-rebuild.service
  '';
};


system.activationScripts.gc-keep-last-5 = {
  text = ''
    echo "[GC] Deleting all but the last 5 generations..."
    ${nixEnv} --delete-generations +5 --profile /nix/var/nix/profiles/system
  '';
};
}
