{ config, pkgs, ... }:

let
  sshPath = "${pkgs.openssh}/bin/ssh";
  gitPath = "${pkgs.git}/bin/git";
  nixosRebuild = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
in {
  systemd.services.nixos-git-pull-rebuild = {
    description = "Pull latest NixOS config and rebuild if changed";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      Environment = "GIT_SSH_COMMAND=${sshPath} -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes";
      ExecStart = pkgs.writeShellScript "git-pull-nixos-and-rebuild" ''
        set -e
        cd /etc/nixos

        echo "[INFO] Fetching..."
        ${gitPath} fetch origin

        LOCAL_COMMIT="$(${gitPath} rev-parse @)"
        REMOTE_COMMIT="$(${gitPath} rev-parse origin/main)"

        if [ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ]; then
          echo "[INFO] New changes found. Pulling and rebuilding..."
          ${gitPath} pull origin main
          ${nixosRebuild} switch
        else
          echo "[INFO] No changes. Skipping rebuild."
        fi
      '';
      User = "root";
    };
  };
}

