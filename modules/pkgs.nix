{ config, pkgs, ... }:{
# steam
  programs.steam = {
    enable = true;
	  remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

# logi Mouse
  services.ratbagd.enable = true;

# Docker
  virtualisation.docker.enable = true;

# packages
  environment.systemPackages = with pkgs; [
  # util
    btop # system monitor
    nvtopPackages.full # GPU monitor
    corectrl # GPU configuration
    pavucontrol # audio devices configuration
    helvum # audio porting
    fastfetch # loonix redditing
    piper # M&K control
    git

  # Gnome Suite
    baobab # disk analyser
    gnome-calculator
    nautilus # file explorer
    gnome-text-editor
    eog # images
    totem # videos
    evince # documents

  # archive and compression
    p7zip
  ];

# exclude garbage
  services.xserver.excludePackages = [ pkgs.xterm ];
}
