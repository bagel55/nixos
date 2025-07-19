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

# Set Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.dconf.enable = true;

  environment.etc."dconf/db/local.d/00-fonts".text = ''
    [org/gnome/desktop/interface]
    font-name='JetBrainsMono Nerd Font 11'
    document-font-name='JetBrainsMono Nerd Font 11'
    monospace-font-name='JetBrainsMono Nerd Font Mono 11'
  '';
}