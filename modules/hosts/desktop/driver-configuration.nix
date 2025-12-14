{ config, lib, pkgs, modulesPath, ... }:
{
	#GPU
	boot.initrd.kernelModules = [ "amdgpu" ];
	boot.kernelModules = [ "kvm-amd" ];
	
	hardware.graphics = {
  	  enable = true;
	  enable32Bit = true;
	};

	hardware.amdgpu.opencl.enable = true;

	systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in [
      "L+ /opt/rocm - - - - ${rocmEnv}"
    ];
	
	#Hostname
	networking.hostName = "bagel-desktop-nixos";
}