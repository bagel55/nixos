{ config, pkgs, ... }: {
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-store
    cosmic-term
  ];

  environment.systemPackages = with pkgs; [
    cosmic-ext-tweaks
    networkmanagerapplet
    wl-clipboard
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}