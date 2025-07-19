{ config, pkgs, ... }:{
# Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

# Auto Login
  services.gnome.gnome-keyring.enable = true;

# Exclude Garbage
  services.gnome.core-apps.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [pkgs.gnome-tour];

# Enable dconf
  programs.dconf.enable = true;

# Set Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}