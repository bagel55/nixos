{ config, pkgs, ... }:
{
imports =[ 
	#./driver-configuration.nix
	./hardware-configuration.nix
	./pkg-inclusions.nix
	./git-ops.nix
	./activation-scripts.nix
];

#Bootloader
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
	boot.loader.systemd-boot.enable = true;
	services.fstrim.enable = true;

#Networking
  networking.networkmanager.enable = true;

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

#Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
	services.xserver.displayManager.gdm.wayland = true;
  services.gnome.core-apps.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [pkgs.gnome-tour];

#Sound
  hardware.bluetooth.enable = true;
  services.pulseaudio.enable = false;
 	security.rtkit.enable = true;
 	services.pipewire = {
    enable = true;
	  alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
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

#Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

#Set Fonts
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
  	nerd-fonts.droid-sans-mono
  ];

#Configure Programs
  services.flatpak.enable = true;
  	
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
  	
#Stuff for OpenRGB
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd"; 

system.stateVersion = "24.05";}
