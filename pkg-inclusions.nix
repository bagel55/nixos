 { config, pkgs, ... }:
 {environment.systemPackages = with pkgs; [
 	# Gnome
 	gnome-shell-extensions #Gnome Extensions
 	gnome-tweaks #Tweaks
 	gnome-themes-extra
 	alacarte #Gnome Menu Editor
 	gnome-calculator #Calculator
 	nautilus #File Explorer
 	gnome-text-editor #Text Editor GUI App
    	eog #Images
    	totem #Videos
    	evince #Documents
    	obsidian #Notes

    	# Util
    	btop #System Monitor
	nvtopPackages.full #GPU Monitor
	corectrl #GPU Configuration
	openrgb #RGB Control
	pavucontrol #Audio Devices Configuration
	helvum #Audio Porting
    	fastfetch #Loonix Redditing

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
    	vesktop #Discord
    	spotify #Spotify

    	# Game Launchers
    	steam #The GOAT
    	lutris #The OG
    	heroic-unwrapped #Epic and GOG
    	xivlauncher #FFXIV Dalamud Launcher
    	prismlauncher #Minecraft Launcher

    	# Emulators
    	rpcs3 #PS3 Emulator
    	xemu #Original Xbox Emulator
    	ryujinx #Switch Emulator
    	retroarchFull #Most Other Emulators

    	# Studio
    	onlyoffice-bin #Office Suite
    	kicad #PCB Schematics and PCB CAD
    	davinci-resolve #Video Editor
    	gimp #Photo Editor
    	inkscape-with-extensions #Illistrator
    	blender #3D Model Editor
    	audacity #Audio Editor
    	obs-studio #OBS
    	linuxKernel.packages.linux_6_6.v4l2loopback #OBS Virtual Cam

    	# Archive and Compression
    	unrar #.rar Files Are Fucking Lame
    	p7zip #The GOAT

    	# Base-Devel
    	vim #Based Text Editor
    	neovim #Based Text Editors Offspring
    	lunarvim #Based Text Editors Offsprings Offspring
    	git #Imagine Not Knowing What Git Is
    	github-desktop #Git For Lazy Fucks
    	tmux #Terminal Now Has Autism

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
