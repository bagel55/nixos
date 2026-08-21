{ config, lib, pkgs, unstable, modulesPath, ... }:
{
	#GPU
	boot.initrd.kernelModules = [ "amdgpu" ];
	boot.kernelModules = [ "kvm-amd" ];
	
	hardware.graphics = {
  	  enable = true;
	  enable32Bit = true;
      package = unstable.mesa;
      package32 = unstable.pkgsi686Linux.mesa;
	};

	#Hostname
	networking.hostName = "bagel-desktop-nixos";
}
