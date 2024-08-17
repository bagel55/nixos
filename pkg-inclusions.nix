 { config, pkgs, ... }:
 {environment.systemPackages = with pkgs; [
 	#Gnome
 	gnome.gnome-shell-extensions
 	gnome-tweaks
 	gnomeExtensions.arc-menu

    	#Hardware Monitor and Util
    	btop #Task Manager
	amdgpu_top #GPU Monitor
	pavucontrol #Audio Devices
	helvum #Audio Porting
	alacritty #Terminal Emulator
	nautilus #File Explorer
    	nautilus-open-any-terminal #Idfk
    	neofetch #Redit User Gaming
	ventoy #Bootable USB Drives
	
    	# Base-Devel
    	python3Full # Python
    	github-desktop # Github
    	git # Git
    	vim # Terminal Text Editor

    	# Wine and friends
    	wine64Packages.stagingFull
    	winePackages.stagingFull
    	winetricks
    	protontricks
    	proton-caller
    	protonup # Proton GE

    	# Gaming and Entertainment
    	steam #The GOAT
    	lutris #The OG
    	ryujinx #Switch Emulator
    	xivlauncher #FFXIV Dalamud Launcher
    	prismlauncher #Minecraft Launcher
    	discord #Discord
    	spotify #Spotify
    	brave #Web Browser

    	#Studio
    	inkscape-with-extensions #Illistrator
    	gimp #Photo Editor
    	davinci-resolve #Video Editor
    	audacity #Audio Editor
    	blender #3D Model Editor
    	unityhub #Game Engine
    	freecad #CAD/CNC
    	kicad #PCB Schematics and PCB CAD
    	#kicad-unstable #Borked?
    	obs-studio #Video Recorder
    	linuxKernel.packages.linux_6_6.v4l2loopback #OBS Virtual Cam
	
    	#File Handlers
    	feh #Images
    	vlc #Videos
    	evince #Documents
    	gnome-text-editor #Text files LITE
    	libreoffice-fresh #Office
 	
    	#Compresed File Unpacker
    	unrar #.rar Files
    	p7zip #The GOAT

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
