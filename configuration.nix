{ config, pkgs, ... }:{
imports =[
  ./modules/system.nix
  ./modules/env.nix
  ./modules/desktopEnviorments/gnome.nix
  #./modules/desktopEnviorments/cosmic.nix
  ./modules/applications/unity.nix
  ./modules/automation/git-ops.nix
  ./modules/automation/activation-scripts.nix
];
system.stateVersion = "24.05";}
