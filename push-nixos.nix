{ config, pkgs, ... }:

let
  pushScript = pkgs.writeShellScriptBin "push-nixos" (builtins.readFile ./push-nixos.sh);
in {
  system.activationScripts.push-nixos = {
    text = ''
      echo "Running post-rebuild Git push..."
      ${pushScript}/bin/push-nixos
    '';
  };
  
  systemd.services.nixos-git-pull = {
    description = "Pull latest NixOS config on boot";
    wantedBy = [ "multi-user.target" ];  # Run at boot after basic system is up
    after = [ "network-online.target" ]; # Wait until network is ready
    requires = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.git}/bin/git -C /etc/nixos pull";
      # Optional: Set up correct SSH environment if needed
      Environment = "GIT_SSH_COMMAND=ssh -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes";
      User = "root";  # Default, but explicit
    };
  };
}

