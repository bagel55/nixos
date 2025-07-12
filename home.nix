{ config, pkgs, ... }: {
  home.username = "bagel";
  home.homeDirectory = "/home/bagel";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" ];
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = "set -g mouse on";
  };

  home.stateVersion = "25.05";
}
