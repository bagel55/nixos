{ config, lib, pkgs, modulesPath, ... }:
{
	#GPU
	boot.initrd.kernelModules = [ "amdgpu" ];
	boot.kernelModules = [ "kvm-amd" ];
	
	hardware.graphics = {
  	  enable = true;
	  enable32Bit = true;
	};
	
	#Hostname
	networking.hostName = "bagel-desktop-nixos";
}