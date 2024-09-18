 { config, pkgs, ... }:
 {environment.systemPackages = with pkgs; [
 	# Gnome
 	gnome-shell-extensions
 	gnome-tweaks
 	gnome-calculator #Calculator
 	nautilus #File Explorer
 	gnome-text-editor #Text files LITE
    	eog #Images
    	totem #Videos
    	evince #Documents

    	# Util
    	btop #System Monitor
	nvtopPackages.full #GPU Monitor
	corectrl #GPU Configuration
	openrgb #RGB Control
	pavucontrol #Audio Devices Configuration
	helvum #Audio Porting
    	fastfetch #Redit User Gaming

    	# Wine and friends
    	wine64Packages.stagingFull
    	winePackages.stagingFull
    	winetricks
    	protontricks
    	proton-caller
    	protonup #Proton GE

    	# Basic Applications
    	alacritty #Terminal Emulator
    	brave #Web Browser
    	vesktop #Discord
    	spotify #Spotify

    	# Game Launchers
    	steam #The GOAT
    	lutris #The OG
    	heroic #Epic and GOG
    	xivlauncher #FFXIV Dalamud Launcher
    	prismlauncher #Minecraft Launcher

    	# Emulators
    	rpcs3 #PS3 Emulator
    	ryujinx #Switch Emulator

    	# Studio
    	onlyoffice-bin #Office Suite
    	kicad #PCB Schematics and PCB CAD
    	obs-studio #OBS
    	linuxKernel.packages.linux_6_6.v4l2loopback #OBS Virtual Cam

    	# Archive and Compression
    	unrar #.rar Files
    	p7zip #The GOAT

    	# Base-Devel
    	neovim #Based text editor
    	github-desktop #Github
    	git #It's git... duh
    	tmux #Terminal now has autism
    	
    	# Vscode Tism Shit
    	(vscode-with-extensions.override {
  	  vscodeExtensions = with vscode-extensions; [
  	    bbenoist.nix
  	  ]
 	  ++ vscode-utils.extensionsFromVscodeMarketplace [
 	    {
 	    name = "code-runner";
 	    publisher = "formulahendry";
 	    version = "0.6.33";
 	    sha256 = "166ia73vrcl5c9hm4q1a73qdn56m0jc7flfsk5p5q41na9f10lb0";
 	    }
 	  ];
	})
];}
