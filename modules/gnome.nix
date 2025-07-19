{ config, pkgs, ... }:{
# enable gnome de
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

# auto login
  services.gnome.gnome-keyring.enable = true;

# exclude garbage
  services.gnome.core-apps.enable = false;
  environment.gnome.excludePackages = with pkgs; [pkgs.gnome-tour];

# dconf
  programs.dconf.enable = true;
}