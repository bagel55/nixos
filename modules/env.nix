{ config, pkgs, unstable, ... }:

{
programs.zsh.enable = true;
users.users.bagel = {
  isNormalUser = true;
  description = "bagel";
  extraGroups = [ "networkmanager" "wheel" "dialout" "input" "kvm" "video" "render" "seat" ];
  useDefaultShell = true;
  shell = pkgs.zsh;
  packages = with pkgs; [
    # basic applications
    alacritty
    discord
    vesktop
    spotify
    telegram
    
    # Games
    prismlauncher
    heroic
    lutris
    moonlight-qt

    # proton
    protontricks

    # Studio
    onlyoffice-desktopeditors
    obs-studio
    github-desktop
    gimp
    vscode
    # IL2CPP's clang++ needs libncurses.so.6 by that name. nixpkgs' ncurses only links that name to libncursesw.so.6,
    # and the FHS env's loader finds libraries by their real name (ld.so.cache), so it takes the non-wide build,
    # whose library is libncurses.so.6.
    (unityhub.override { extraLibs = pkgs: [ (pkgs.ncurses.override { unicodeSupport = false; }) ]; })
    dotnetCorePackages.sdk_10_0
    blender

    # Printing
    freecad
    qidi-studio

    # util
    btop # system monitor
    pavucontrol # audio devices configuration
    fastfetch # loonix redditing
    git
    p7zip
    piper
    xclicker # autoclicker (X11/XWayland windows only)
    qbittorrent
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

# MangoHud in every Vulkan/OpenGL app (Steam, non-Steam games, Unity, ...).
# Config lives in home.nix; no_display = true keeps it hidden until
# toggled (Right Shift + F12).
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
    unstable.proton-ge-bin
  ];
};
}
