{ config, pkgs, ... }:{
imports =[
  ./modules/hosts/desktop/hardware-configuration.nix
  ./modules/hosts/desktop/driver-configuration.nix
  ./modules/system.nix
  ./modules/gnome.nix
  ./modules/pkgs.nix
  ./modules/user.nix
  ./modules/automation/git-ops.nix
  ./modules/automation/activation-scripts.nix
];
system.stateVersion = "24.05";}
