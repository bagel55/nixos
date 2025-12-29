{ config, pkgs, ... }:{
imports =[
  ./modules/system.nix
  ./modules/cosmic.nix
  ./modules/pkgs.nix
  ./modules/user.nix
  ./modules/automation/git-ops.nix
  ./modules/automation/activation-scripts.nix
];
system.stateVersion = "24.05";}
