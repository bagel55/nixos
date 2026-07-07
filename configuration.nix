{ config, pkgs, ... }:{
imports =[
  ./modules/system.nix
  ./modules/env.nix
  ./modules/desktopEnviorments/gnome.nix
  #./modules/desktopEnviorments/cosmic.nix
  #./modules/desktopEnviorments/plasma.nix
  ./modules/automation/git-ops.nix
  ./modules/automation/activation-scripts.nix
];
system.stateVersion = "25.11";}
