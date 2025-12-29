{ config, pkgs, ... }:{
# steam
  programs.steam = {
    enable = true;
	  remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession = {
    enable = true;
    env = {
      WLR_RENDERER = "vulkan";
      DXVK_HDR = "1";
      ENABLE_GAMESCOPE_WSI = "1";
      WINE_FULLSCREEN_FSR = "1";
      SDL_VIDEODRIVER = "x11";
    };
    args = [
      "--xwayland-count 2"
      "--expose-wayland"
      "-e"
      "--steam"
      "--adaptive-sync"
      "--hdr-enabled"
      "--hdr-itm-enable"
      "--prefer-output HDMI-A-1"
      "--output-width 2560"
      "--output-height 1440"
    ];
  };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
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