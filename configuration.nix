{ config, pkgs, ... }:
{
	imports =[ 
	  ./hardware-configuration.nix
	  ./driver-configuration.nix
	  ./pkg-inclusions.nix
	];
	
	#Bootloader
	boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
	boot.loader.systemd-boot.enable = true;
  
  	#Nix Channels
  	system.autoUpgrade.enable = true;
  	system.autoUpgrade.allowReboot = true;
  	system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";
  	nixpkgs.config.channel = "https://channels.nixos.org/nixos-unstable";
  
  	#Networking
  	networking.networkmanager.enable = true;
  	services.avahi = {
  		enable = true;
  		nssmdns4 = true;
  		openFirewall = true;
	};
  	
  	#Printing
  	services.printing.enable = true;

  
  	#Time Zone
  	time.timeZone = "America/Los_Angeles";
  
  	#Internationalisation Properties
  	i18n.defaultLocale = "en_US.UTF-8";
  	i18n.extraLocaleSettings = {
    	  LC_ADDRESS = "en_US.UTF-8";
    	  LC_IDENTIFICATION = "en_US.UTF-8";
    	  LC_MEASUREMENT = "en_US.UTF-8";
    	  LC_MONETARY = "en_US.UTF-8";
    	  LC_NAME = "en_US.UTF-8";
    	  LC_NUMERIC = "en_US.UTF-8";
    	  LC_PAPER = "en_US.UTF-8";
    	  LC_TELEPHONE = "en_US.UTF-8";
    	  LC_TIME = "en_US.UTF-8";
  	};
  
  	#Configure keymap in X11
  	services.xserver = {
    	  xkb.layout = "us";
    	  xkb.variant = "";
  	};
  
  	#Enable the X11 windowing system.
  	services.xserver.enable = true;
  
  	#Enable the GNOME Desktop Environment.
  	services.xserver.displayManager.gdm.enable = true;
  	services.xserver.desktopManager.gnome.enable = true;
  	services.gnome.core-utilities.enable = false;
  	services.xserver.excludePackages = [ pkgs.xterm ];
  	environment.gnome.excludePackages = with pkgs; [pkgs.gnome-tour];
  
  	#Sound
  	hardware.bluetooth.enable = true;
  	hardware.bluetooth.powerOnBoot = true;
  	hardware.pulseaudio.enable = false;
 	security.rtkit.enable = true;
 	services.pipewire = {
    	  enable = true;
	  alsa.enable = true;
    	  alsa.support32Bit = true;
    	  pulse.enable = true; 
    	  jack.enable = true;
	};
  
  	#User Config
  	programs.zsh.enable = true;
  	users.users.bagel = {
    	  isNormalUser = true;
    	  description = "bagel";
    	  extraGroups = [ "networkmanager" "wheel" "dialout" "input" ];
    	  useDefaultShell = true;
    	  shell = pkgs.zsh;
    	  packages = with pkgs; [];
  	};
  
  	#Automatic Login For User
  	services.displayManager.autoLogin.enable = true;
  	services.displayManager.autoLogin.user = "bagel";
  	systemd.services."getty@tty1".enable = false;
  	systemd.services."autovt@tty1".enable = false;
  
  	#Allow unfree packages
  	nixpkgs.config.allowUnfree = true;
  	nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  	#Set Fonts
  	fonts.packages = with pkgs; [
  	  nerdfonts
  	];
  
  	#Configure Programs
  	programs.steam = {
    	  enable = true;
    	  remotePlay.openFirewall = true;
    	  dedicatedServer.openFirewall = true;
  	};
  	hardware.graphics = {
   	  enable = true;
   	  extraPackages = with pkgs;[
     	    rocmPackages.clr.icd
     	  ];
  	};
  
  system.stateVersion = "unstable";}
