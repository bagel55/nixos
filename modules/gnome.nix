{ config, pkgs, ... }:{
# enable gnome
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

# gnome apps
  environment.systemPackages = with pkgs; [
    gnome-shell-extensions
    gnome-tweaks
    gnome-themes-extra
    gnome-disk-utility
    alacarte # gnome menu editor
    baobab # disk analyser
    gnome-calculator
    nautilus # file explorer
    gnome-text-editor
    eog # images
    totem # videos
    evince # documents
    gnome-music
    seahorse
  ];
}