 { config, pkgs, ... }:
 let
  unstableSmall = import <nixos-unstable-small> { config = {}; };
in
 {environment.systemPackages = with pkgs; [
 	
 	# Gnome
 	gnome-shell-extensions #Gnome Extensions
 	gnome-tweaks #Tweaks
 	gnome-themes-extra
 	gnome-disk-utility #Disk Tool
 	alacarte #Gnome Menu Editor
 	baobab #Disk Analyser
 	gnome-calculator #Calculator
 	nautilus #File Explorer
 	gnome-text-editor #Text Editor GUI App
    	eog #Images
    	totem #Videos
    	evince #Documents

    	# Util
    	btop #System Monitor
	nvtopPackages.full #GPU Monitor
	corectrl #GPU Configuration
	openrgb-with-all-plugins #RGB Control
	pavucontrol #Audio Devices Configuration
	helvum #Audio Porting
	#ventoy-full #Bootable Drive Solution
    	fastfetch #Loonix Redditing
    	obsidian #Notes

    	# Wine and friends
    	wine64Packages.stagingFull #Wine 64 Bit Tools
    	winePackages.stagingFull #Wine 32 Bit Tools
    	winetricks #Wine Prefix Editor
    	protontricks #Proton Prefix Editor
    	proton-caller #Proton Updater
    	protonup #Proton GE
    	protonup-qt #Proton For Lutris

    	# Basic Applications
    	alacritty #Terminal Emulator
    	brave #Web Browser
    	discord #Discord
    	spotify #Spotify

    	# Game Launchers
    	steam #The GOAT
    	lutris #The OG
    	heroic-unwrapped #Epic and GOG
    	xivlauncher #FFXIV Dalamud Launcher
    	prismlauncher #Minecraft Launcher
    	r2modman #Mod Stuffs For Loads of Games

    	# Emulators
    	rpcs3 #PS3 Emulator
    	xemu #Original Xbox Emulator
    	ryujinx #Switch Emulator
    	retroarchFull #Most Other Emulators
    	shadps4 #PS4 I Think

    	# Studio
    	onlyoffice-bin #Office Suite
    	davinci-resolve #Video Editor
    	gimp #Photo Editor
    	inkscape-with-extensions #Illistrator
    	blender #3D Model Editor
    	audacity #Audio Editor
    	obs-studio #OBS
    	linuxKernel.packages.linux_6_6.v4l2loopback #OBS Virtual Cam
    	kicad
    	unityhub

    	# Archive and Compression
    	unrar #.rar Files Are Fucking Lame
    	p7zip #The GOAT

    	# Base-Devel
    	distrobox
        xorg.xhost
    	vim #Based Text Editor
    	git #Imagine Not Knowing What Git Is
    	git-lfs
    	github-desktop #Git For Lazy Fucks
    	tmux #Terminal Now Has Autism
    	vscode
    	dotnet-sdk
];}
