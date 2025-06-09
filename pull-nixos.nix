{ config, pkgs, ... }:

let
  sshPath = "${pkgs.openssh}/bin/ssh";
in {
  systemd.services.nixos-git-pull = {
    description = "Pull latest NixOS config on boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.git}/bin/git -C /etc/nixos pull";
      Environment = "GIT_SSH_COMMAND=${sshPath} -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes";
      User = "root";
    };
  };
}

