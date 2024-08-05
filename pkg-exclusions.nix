{ config, pkgs, ... }:
{services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    epiphany    # web browser
    gedit       # text editor
    simple-scan # document scanner
    yelp        # help viewer
    file-roller # archive manager
    geary       # email client
    seahorse    # password manager
    gnome-system-monitor
    gnome-calendar
    gnome.gnome-characters
    gnome.gnome-clocks
    gnome.gnome-contacts
    gnome-font-viewer
    gnome.gnome-logs
    gnome.gnome-maps
    gnome.gnome-music
    gnome-photos
    gnome-system-monitor
    gnome.gnome-weather
    gnome-disk-utility
    pkgs.gnome-connections
    pkgs.gnome-console
    pkgs.gnome-tour
];}
