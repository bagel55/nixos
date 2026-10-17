{ config, lib, pkgs, unstable, modulesPath, ... }:
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

	users.users.bagel.packages = with pkgs; [
	  nvtopPackages.amd
	];
}
