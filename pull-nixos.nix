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
      Environment = "GIT_SSH_COMMAND=${sshPath} -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes NIX_PATH=/home/bagel/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels";
      ExecStart = pkgs.writeShellScript "git-pull-nixos-and-rebuild" ''
        set -e
        cd /etc/nixos
        echo "[INFO] Pulling latest changes and rebuilding NixOS..."
        ${gitPath} pull origin main
        ${pkgs.nix}/bin/nix-channel --update
        ${nixosRebuild} switch
      '';
      User = "root";
    };
  };
}