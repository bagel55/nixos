{ config, pkgs, ... }:{
imports =[
  ./modules/system.nix
  ./modules/env.nix
  ./modules/desktopEnvironments/gnome.nix
  #./modules/desktopEnvironments/cosmic.nix
  #./modules/desktopEnvironments/plasma.nix
  ./modules/automation/git-ops.nix
  ./modules/automation/activation-scripts.nix
  ./modules/automation/update-command.nix
];
system.stateVersion = "26.05";}
