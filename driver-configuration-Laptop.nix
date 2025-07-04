{ config, lib, pkgs, modulesPath, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "nvidia.NVreg_OpenRmEnableUnsupportedGpus=1"
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_RegistryDwords=PerfLevelSrc=0x2222"
  ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  networking.hostName = "Nixos-bagel-Laptop";
}
