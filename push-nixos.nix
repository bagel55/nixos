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
}

