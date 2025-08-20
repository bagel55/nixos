{ config, pkgs, ... }:{
# enable gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

# exclude garbage
  services.gnome.core-apps.enable = false;
  environment.gnome.excludePackages = with pkgs; [ pkgs.gnome-tour gnome-backgrounds ];

# dconf
  programs.dconf.enable = true;

# fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

# gnome apps
  environment.systemPackages = with pkgs; [
    gnome-shell-extensions
    gnome-tweaks
    gnome-themes-extra
    gnome-disk-utility
    gnome-logs
    cheese
    alacarte # gnome menu editor
    baobab # disk analyser
    gnome-calculator
    nautilus # file explorer
    gnome-text-editor
    eog # images
    totem # videos
    evince # documents
  ];
}