{ config, pkgs, ... }:{
imports =[
  ./modules/hosts/Desktop/hardware-configuration.nix
  ./modules/hosts/Desktop/driver-configuration.nix
  ./modules/system.nix
  ./modules/gnome.nix
  ./pkg-inclusions.nix
  ./modules/development.nix
  ./modules/user.nix
  ./modules/automation/git-ops.nix
  ./modules/automation/activation-scripts.nix
];
system.stateVersion = "24.05";}
