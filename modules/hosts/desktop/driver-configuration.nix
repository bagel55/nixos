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

  ################################################
  #########AHHHHHHHHHHHHHHHHHHHHHHHHHHH###########
  ################################################
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.rocm-runtime
    rocmPackages.rocm-device-libs
    rocmPackages.rocm-smi
  ];

  environment.systemPackages = with pkgs; [
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
    pciutils
  ];

  # Required for RDNA3
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
    HSA_OVERRIDE_GFX_VERSION = "11.0.0";
  };

	#stuff for ROCm for stable diff
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
	################################################
  #########AHHHHHHHHHHHHHHHHHHHHHHHHHHH###########
  ################################################

	#Hostname
	networking.hostName = "bagel-desktop-nixos";
}