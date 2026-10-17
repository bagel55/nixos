{ ... }:
{
  imports = [
    ./home/terminal.nix # Alacritty
    ./home/shell.nix    # zsh, Powerlevel10k, tmux, direnv
    ./home/gnome.nix    # extensions, fonts
    ./home/mangohud.nix # Right Shift + F12 cycles presets
  ];

  # home-manager itself
  home.enableNixpkgsReleaseCheck = false;
  home.username = "bagel";
  home.homeDirectory = "/home/bagel";
  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
