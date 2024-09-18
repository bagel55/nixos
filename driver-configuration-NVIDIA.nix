  { config, lib, pkgs, modulesPath, ... }:

{ 
  boot.extraModulePackages = [ pkgs.linuxPackages.nvidia_x11 ];
  boot.blacklistedKernelModules = ["nouveau" "nvidia_drm" "nvidia_modeset" "nvidia" ];
  environment.systemPackages = with pkgs; [ pkgs.linuxPackages.nvidia_x11 ];
  services.xserver.videoDrivers = ["nvidia"];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };
    
    networking.hostName = "Nixos-bagel-Laptop";
  }
