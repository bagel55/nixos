{ config, pkgs, unstable, ... }:

let
  qidiStudioFixed = unstable.appimageTools.wrapType2 {
    pname = "qidi-studio";
    version = "2.07.02.60";

    src = unstable.fetchurl {
      url = "https://github.com/QIDITECH/QIDIStudio/releases/download/v2.07.02.60/QIDIStudio_v02.07.02.60_Ubuntu24.AppImage";
      hash = "sha256-1H0rLI3V8W1I+KIbolQg/Wat9WsACMy1RIdyU0s8seg=";
    };

    extraPkgs = p: [
      p.webkitgtk_4_1
      p.libsoup_3
    ];
  };
in
{
programs.zsh.enable = true;
users.users.bagel = {
  isNormalUser = true;
  description = "bagel";
  extraGroups = [ "networkmanager" "wheel" "dialout" "input" "kvm" "docker" "video" "render" "seat" ];
  useDefaultShell = true;
  shell = pkgs.zsh;
  packages = with pkgs; [
    # basic applications
    alacritty 
    brave
    discord
    vesktop
    spotify
    
    # Games
    prismlauncher
    xivlauncher
    heroic
    lutris

    # proton
    protontricks

    # Studio
    onlyoffice-desktopeditors
    obs-studio
    github-desktop
    gimp
    vscode
    unityhub
    dotnetCorePackages.sdk_10_0
    blender

    # Printing
    freecad
    unstable.qidi-studio

    # util
    btop # system monitor
    nvtopPackages.full # GPU monitor
    corectrl # GPU configuration
    pavucontrol # audio devices configuration
    fastfetch # loonix redditing
    git
    p7zip
    vulkan-tools
    piper
  ];
};

# Gamemode
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

# Mango Hud
environment.sessionVariables = {
  MANGOHUD = "1";
  MANGOHUD_DLSYM = "1";
};

# steam
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
  dedicatedServer.openFirewall = true;

  extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
};
}
