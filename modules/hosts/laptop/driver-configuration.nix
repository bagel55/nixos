{ config, lib, pkgs, unstable, modulesPath, ... }:
{
  hardware.nvidia = {
    package =
      (unstable.linuxPackagesFor config.boot.kernelPackages.kernel)
        .nvidiaPackages.new_feature;

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

  users.users.bagel.packages = with pkgs; [
    nvtopPackages.nvidia
  ];

  networking.hostName = "bagel-laptop-nixos";
}