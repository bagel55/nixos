{ config, pkgs, ... }:{
# user config
  programs.zsh.enable = true;
  users.users.bagel = {
    isNormalUser = true;
    description = "bagel";
    extraGroups = [ "networkmanager" "wheel" "dialout" "input" ];
    useDefaultShell = true;
    shell = pkgs.zsh;
    packages = with pkgs; [
      # basic applications
        alacritty 
        brave
        discord
        vesktop
        spotify

      # games
        lutris
        bottles
        heroic-unwrapped
        xivlauncher
        prismlauncher

      # game util
        gamemode
        samrewritten
        r2modman
        fflogs
        satisfactorymodmanager

      # emulators
        rpcs3
        shadps4
        xemu
        ryujinx
        retroarchFull
        
      # proton
        protontricks
        proton-caller
        protonup
        protonup-qt

      # Studio
        onlyoffice-bin
        davinci-resolve
        gimp
        inkscape-with-extensions
        drawing
        blender
        audacity
        obs-studio
        kicad
        obsidian
        flowblade
    ];
  };
}