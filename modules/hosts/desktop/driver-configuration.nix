{ config, lib, pkgs, modulesPath, ... }:
{
	#GPU
	boot.initrd.kernelModules = [ "amdgpu" ];
	boot.kernelModules = [ "kvm-amd" "zenergy" ];

	# CPU power sensor readable without root (MangoHud CPU watts)
	boot.extraModulePackages = [ config.boot.kernelPackages.zenergy ];
	
	hardware.graphics = {
  	  enable = true;
	  enable32Bit = true;
	};

	hardware.amdgpu.overdrive.enable = true;
	services.lact.enable = true;

	#Hostname
	networking.hostName = "bagel-desktop-nixos";

	users.users.bagel.packages = with pkgs; [
	  nvtopPackages.amd
	];
}
