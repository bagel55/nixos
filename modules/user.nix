{ config, pkgs, ... }:{
# user config
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
        
        prismlauncher
        xivlauncher
        heroic
        lutris

        xclicker
        scanmem

      # proton
        protontricks
        protonup-ng

      # Studio
        onlyoffice-desktopeditors
        obs-studio
        github-desktop
        gimp
        vscode
        unityhub
        blender
    ];
  };
}

