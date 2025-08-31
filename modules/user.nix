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
        fflogs
        satisfactorymodmanager
        
      # proton
        protontricks
        proton-caller
        protonup
        protonup-qt

      # Studio
        onlyoffice-bin
        gimp
        inkscape-with-extensions
        blender
        obs-studio
    ];
  };
}