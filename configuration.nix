{ config, pkgs, ... }:{
imports =[
  ./modules/hosts/Desktop/hardware-configuration.nix
  ./modules/hosts/Desktop/driver-configuration.nix
  ./modules/system.nix
  ./modules/gnome.nix
  ./modules/pkg-inclusions.nix
  ./modules/user.nix
  ./modules/automation/git-ops.nix
  ./modules/automation/activation-scripts.nix
];
system.stateVersion = "24.05";}
