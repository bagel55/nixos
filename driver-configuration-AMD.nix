{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  
  networking.hostName = "Nixos-bagel-Desktop";
}
