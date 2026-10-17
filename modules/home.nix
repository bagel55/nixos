{ pkgs, ... }:
{
  imports = [
    ./home/terminal.nix # Alacritty
    ./home/shell.nix    # zsh, Powerlevel10k, tmux, direnv
    ./home/gnome.nix    # extensions, fonts
    ./home/mangohud.nix # Right Shift + F12 cycles presets
    ./home/cleanup.nix  # XDG dotfile moves + inactive desktop leftovers
  ];

  # home-manager itself
  home.enableNixpkgsReleaseCheck = false;
  home.username = "bagel";
  home.homeDirectory = "/home/bagel";
  programs.home-manager.enable = true;

  # Standard XDG dirs/env vars; run `xdg-ninja` to audit dotfile clutter in ~
  xdg.enable = true;
  home.packages = [ pkgs.xdg-ninja ];

  home.stateVersion = "25.11";
}
