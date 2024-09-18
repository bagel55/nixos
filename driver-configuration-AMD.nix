{ config, lib, pkgs, modulesPath, ... }:
{
	#GPU
	boot.initrd.kernelModules = [ "amdgpu" ];
	boot.kernelModules = [ "kvm-amd" ];

	hardware.graphics = {
   	  enable = true;
   	  extraPackages = with pkgs;[
     	    rocmPackages.clr.icd
     	  ];
  	};

	#Hostname
	networking.hostName = "Nixos-bagel-Desktop";
}
