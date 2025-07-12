{ config, pkgs, ... }:{
imports =[
  ./hardware-configuration.nix
  ./system.nix
  #./user.nix
  ./driver-configuration.nix
  ./pkg-inclusions.nix
  ./git-ops.nix
  ./activation-scripts.nix
];
system.stateVersion = "24.05";}
