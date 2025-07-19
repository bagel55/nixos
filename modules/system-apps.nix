{ config, pkgs, ... }:{
# distro box
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

# OpenRGB
  services.hardware.openrgb.enable = true;

# exclude garbage
  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.systemPackages = with pkgs; [
  # gnome apps
    gnome-shell-extensions
    gnome-tweaks
    gnome-themes-extra
    gnome-disk-utility
    gnome-font-viewer
    alacarte # gnome menu editor
    baobab # disk analyser
    gnome-calculator
    nautilus # file explorer
    gnome-text-editor
    eog # images
    totem # videos
    evince # documents

  # util
    btop # system monitor
    nvtopPackages.full # GPU monitor
    corectrl # GPU configuration
    openrgb-with-all-plugins
    pavucontrol # audio devices configuration
    helvum # audio porting
    fastfetch # loonix redditing
    linuxKernel.packages.linux_6_6.v4l2loopback # OBS virtual cam

  # wine
    wine64Packages.stagingFull
    winePackages.stagingFull
    winetricks

  # base-devel
    vim
    neovim
    lunarvim
    git
    git-lfs
    github-desktop
    distrobox
    xorg.xhost
    vscode
    dotnet-sdk
    unityhub
    godot

  # archive and compression
    unrar
    p7zip
  ];
}