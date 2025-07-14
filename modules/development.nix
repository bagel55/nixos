{ config, pkgs, ... }:{
# Packages
  environment.systemPackages = with pkgs; [
    vim
    neovim
    lunarvim

    git
    git-lfs
    github-desktop

    distrobox
    xorg.xhost

    vscode
    dotnet-sdk
    unityhub
    godot
  ];

# Distro Box
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}