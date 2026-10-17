{ config, pkgs, unstable, ... }:

let
  qidiStudio = import ./packages/qidi-studio.nix { inherit unstable; };
in
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
    qidiStudio

    # util
    btop # system monitor
    pavucontrol # audio devices configuration
    fastfetch # loonix redditing
    git
    p7zip
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

# MangoHud is configured in home.nix; enable it per game with the
# Steam launch option: mangohud gamemoderun %command%

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
