{ config, pkgs, ... }:{
# distro box
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

# steam
  programs.steam = {
    enable = true;
	  remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

# OpenRGB
  services.hardware.openrgb.enable = true;

# Logi Mouse
  services.ratbagd.enable = true;

  environment.systemPackages = with pkgs; [
  # util
    btop # system monitor
    nvtopPackages.full # GPU monitor
    corectrl # GPU configuration
    openrgb-with-all-plugins
    pavucontrol # audio devices configuration
    helvum # audio porting
    fastfetch # loonix redditing
    linuxKernel.packages.linux_6_6.v4l2loopback # OBS virtual cam
    piper # M&K control

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

# exclude garbage
  services.xserver.excludePackages = [ pkgs.xterm ];
}