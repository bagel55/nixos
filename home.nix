{ config, pkgs, ... }:{
  home.username = "bagel";
  home.homeDirectory = "/home/bagel";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" "docker" ];
    };
    shellAliases = {
      ll = "ls -al";
      gs = "git status";
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    extraConfig = ''
      set -g mouse on
      bind r source-file ~/.tmux.conf \; display-message "Reloaded!"
    '';
  };

  home.stateVersion = "25.05";  
}
