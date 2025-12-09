{ config, pkgs, ... }:{
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-store
  ];

  environment.systemPackages = with pkgs; [
    cosmic-ext-tweaks
  ];
}