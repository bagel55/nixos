{ config, pkgs, ... }:{
# enable gnome
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  services.desktopManager.gnome.enable = true;
# exclude garbage
  services.gnome.core-apps.enable = false;
  environment.gnome.excludePackages = with pkgs; [ pkgs.gnome-tour gnome-backgrounds ];
  services.xserver.excludePackages = [ pkgs.xterm ];

# packages
  environment.systemPackages = with pkgs; [
  # Gnome apps
    gnome-shell-extensions
    gnome-tweaks
    gnome-themes-extra
    gnome-disk-utility
    snapshot
    alacarte

  # Gnome Suite
    baobab # disk analyser
    gnome-calculator
    nautilus # file explorer
    gnome-text-editor
    eog # images
    totem # videos
  ];
}