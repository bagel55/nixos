{ config, pkgs, ... }:
let
unstableSmall = import <nixos-unstable-small> { config = {}; };
in
{
#Steam
programs.steam = {
  enable = true;
	remotePlay.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
  dedicatedServer.openFirewall = true;
};

#Distro Box
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
};

#OpenRGB
services.hardware.openrgb.enable = true;

#nix packages
environment.systemPackages = with pkgs; [

# Gnome
gnome-shell-extensions #Gnome extensions.
gnome-tweaks #Tweaks.
gnome-themes-extra #More themes to add propper dark mode.
gnome-disk-utility #Disk tool.
alacarte #Gnome menu editor.
baobab #Disk analyser.
gnome-calculator #Calculator.
nautilus #File explorer.
gnome-text-editor #Text editor GUI app.
eog #Images.
totem #Videos.
evince #Documents.
seahorse #Passwords and Keys

# Util
btop #System monitor.
nvtopPackages.full #GPU monitor.
corectrl #GPU configuration.
openrgb-with-all-plugins #RGB control.
pavucontrol #Audio devices configuration.
helvum #Audio porting.
fastfetch #Loonix redditing.
obsidian #Notes.

# Wine and friends
wine64Packages.stagingFull #Wine 64 bit tools.
winePackages.stagingFull #Wine 32 bit tools.
winetricks #Wine prefix editor.
protontricks #Proton prefix editor.
proton-caller #Proton updater.
protonup #Proton GE.
protonup-qt #Proton for easy apply to other apps.

# Archive and Compression
unrar #.rar files are fucking lame.
p7zip #The GOAT.

# Base-Devel
distrobox #Containers instead of vm's.
xorg.xhost #fml.
vim #The text editor my grandfather used.
git #Imagine not knowing what git is.
github-desktop #Git for lazy fucks.
git-lfs #Git for fat fucks.
vscode #Text editor that gets paid 6 figures.
dotnet-sdk #C# Things, not a big fan.
direnv #Load env variables in CLI.
];}
