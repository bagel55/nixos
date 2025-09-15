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

      # proton
        protontricks
        protonup

      # Studio
        onlyoffice-bin
        obs-studio
        dotnet-sdk
        unityhub
        github-desktop
    ];
  };
}
