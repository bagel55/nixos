{ config, pkgs, ... }:{
# Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

# Auto Login
  services.displayManager.autoLogin = {
    enable = true;
    user = "bagel";
  };
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  services.gnome.gnome-keyring.enable = true;

# Exclude Garbage
  services.gnome.core-apps.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [pkgs.gnome-tour];

# Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

# Set Fonts
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
  	nerd-fonts.droid-sans-mono
  ];

# Gnome apps
  environment.systemPackages = with pkgs; [
    gnome-shell-extensions # Gnome extensions.
    gnome-tweaks # Tweaks.
    gnome-themes-extra # More themes to add propper dark mode.
    gnome-disk-utility # Disk tool.
    alacarte # Gnome menu editor.
    baobab # Disk analyser.
    gnome-calculator # Calculator.
    nautilus # File explorer.
    gnome-text-editor # Text editor GUI app.
    eog # Images.
    totem # Videos.
    evince # Documents.
  ];
}