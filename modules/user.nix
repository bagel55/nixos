{ config, pkgs, ... }:{
# user config
  programs.zsh.enable = true;
  users.users.bagel = {
    isNormalUser = true;
    description = "bagel";
    extraGroups = [ "networkmanager" "wheel" "dialout" "input" "kvm" "docker" ];
    useDefaultShell = true;
    shell = pkgs.zsh;
    packages = with pkgs; [
      # basic applications
        alacritty 
        brave
        discord
        vesktop
        prismlauncher
        xivlauncher
        spotify

      # proton
        protontricks
        proton-caller
        protonup

      # Studio
        onlyoffice-bin
        obs-studio
        github-desktop
        gimp
        vscode
    ];
  };
}

