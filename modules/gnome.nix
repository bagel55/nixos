{ config, pkgs, ... }:{
# enable gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

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
    gnome-logs
    snapshot
    alacarte # gnome menu editor
  ];
}