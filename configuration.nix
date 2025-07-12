{ config, pkgs, ... }:{
imports =[
  ./hardware-configuration.nix
  ./system.nix
  #<home-manager/nixos>
  ./user.nix
  ./driver-configuration.nix
  ./pkg-inclusions.nix
  ./git-ops.nix
  ./activation-scripts.nix
];

nix = {
  package = pkgs.nixVersions.stable;
  extraOptions = ''
    experimental-features = nix-command flakes
  '';
};

system.stateVersion = "24.05";}
