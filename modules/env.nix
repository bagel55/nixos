{ config, pkgs, unstable, ... }:

let
  qidiStudioPname = "qidi-studio";
  qidiStudioVersion = "2.07.02.60";

  qidiStudioSrc = unstable.fetchurl {
    url = "https://github.com/QIDITECH/QIDIStudio/releases/download/v${qidiStudioVersion}/QIDIStudio_v0${qidiStudioVersion}_Ubuntu24.AppImage";
    hash = "sha256-1H0rLI3V8W1I+KIbolQg/Wat9WsACMy1RIdyU0s8seg=";
  };

  qidiStudioContents = unstable.appimageTools.extract {
    pname = qidiStudioPname;
    version = qidiStudioVersion;
    src = qidiStudioSrc;
  };

  qidiStudioFixed = unstable.appimageTools.wrapType2 {
    pname = qidiStudioPname;
    version = qidiStudioVersion;
    src = qidiStudioSrc;

    extraPkgs = p: [
      p.webkitgtk_4_1
      p.libsoup_3
    ];

    nativeBuildInputs = [
      unstable.makeWrapper
    ];

    extraInstallCommands = ''
      install -m 444 -D \
        ${qidiStudioContents}/QIDIStudio.desktop \
        $out/share/applications/QIDIStudio.desktop

      install -m 444 -D \
        ${qidiStudioContents}/QIDIStudio.png \
        $out/share/icons/hicolor/scalable/apps/QIDIStudio.png

      substituteInPlace \
        $out/share/applications/QIDIStudio.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=qidi-studio'

      wrapProgram "$out/bin/qidi-studio" \
        --set-default WEBKIT_DISABLE_COMPOSITING_MODE 0 \
        --set-default WEBKIT_DISABLE_DMABUF_RENDERER 0
    '';
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
    qidiStudioFixed

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
