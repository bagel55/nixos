{ config, pkgs, ... }:{
# user config
  programs.zsh.enable = true;
  users.users.bagel = {
    isNormalUser = true;
    description = "bagel";
    extraGroups = [ "networkmanager" "wheel" "dialout" "input" ];
    useDefaultShell = true;
    shell = pkgs.zsh;
  };
}