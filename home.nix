{ config, pkgs, ... }: {
  home.username = "bagel";
  home.homeDirectory = "/home/bagel";

  programs.zsh.enable = true;

  home.packages = with pkgs; [
    git
    neovim
  ];

  home.stateVersion = "25.05";
}
