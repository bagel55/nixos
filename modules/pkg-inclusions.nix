{ config, pkgs, ... }:{
  environment.systemPackages = with pkgs; [
    # Gnome Apps
    gnome-shell-extensions
    gnome-tweaks
    gnome-themes-extra
    gnome-disk-utility
    alacarte # Gnome menu editor.
    baobab # Disk analyser.
    gnome-calculator
    nautilus # File explorer.
    gnome-text-editor
    eog # Images.
    totem # Videos.
    evince # Documents.

    # Util
    btop # System monitor.
    nvtopPackages.full # GPU monitor.
    corectrl # GPU configuration.
    openrgb-with-all-plugins
    pavucontrol # Audio devices configuration.
    helvum # Audio porting.
    fastfetch # Loonix redditing.
    linuxKernel.packages.linux_6_6.v4l2loopback # OBS virtual cam.

    # Wine
    wine64Packages.stagingFull
    winePackages.stagingFull
    winetricks

    # Archive and Compression
    unrar
    p7zip
  ];
}