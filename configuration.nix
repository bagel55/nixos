{ config, pkgs, ... }:{
imports =[
  ./hosts/Desktop/hardware-configuration.nix
  ./system.nix
  ./user.nix
  ./hosts/Desktop/driver-configuration.nix
  ./pkg-inclusions.nix
  ./git-ops.nix
  ./activation-scripts.nix
];
system.stateVersion = "24.05";}
