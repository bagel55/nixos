  { config, lib, pkgs, modulesPath, ... }:

{
  boot.kernelParams = [ "intel_pstate=disable" "nvidia.NVreg_OpenRmEnableUnsupportedGpus=1" "nvidia-drm.modeset=1" "nvidia.NVreg_RegistryDwords=PerfLevelSrc=0x2222" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

services.xserver = {
  videoDrivers = [ "nvidia" ];
  deviceSection = ''
    Section "Device"
      Identifier "NVIDIA GPU"
      Driver "nvidia"
      BusID "PCI:1:0:0" # Adjust to your NVIDIA GPU PCI bus ID (find with lspci)
      Option "AllowEmptyInitialConfiguration" "true"
      Option "PrimaryGPU" "yes"
    EndSection
  '';
};

hardware.graphics = {
  enable = true;
  enable32Bit = true;
};

hardware.nvidia = {
  package = pkgs.linuxPackages.nvidia_x11;
  modesetting.enable = true;
  powerManagement.enable = true;
  powerManagement.finegrained = false;
  open = false;
  nvidiaSettings = true;
};

networking.hostName = "Nixos-bagel-Laptop";
}