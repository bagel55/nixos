{ config, pkgs, ... }:{
# steam
  programs.steam = {
    enable = true;
	  remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        desiredgov = "performance";
        inhibit_screensaver = 1;
        disable_splitlock = 1;
      };
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

# packages
  environment.systemPackages = with pkgs; [
  # util
    btop # system monitor
    nvtopPackages.full # GPU monitor
    corectrl # GPU configuration
    pavucontrol # audio devices configuration
    helvum # audio porting
    fastfetch # loonix redditing
    git
    p7zip
  ];
}
