{ config, pkgs, ... }:{
# Boot
	boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_lqx;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

# SSD Trim
	services.fstrim.enable = true;

# Networking
  networking.networkmanager.enable = true;

# Time Zone
  time.timeZone = "America/Los_Angeles";

# Internationalisation Properties
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

# Sound
  hardware.bluetooth.enable = true;
  services.pulseaudio.enable = false;
 	security.rtkit.enable = true;
 	services.pipewire = {
    enable = true;
	  alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
    jack.enable = true;
	};

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Steam
  programs.steam = {
    enable = true;
	  remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

# OpenRGB
  services.hardware.openrgb.enable = true;

# Systemwide apps
  environment.systemPackages = with pkgs; [
    # Util
    btop # System monitor.
    nvtopPackages.full # GPU monitor.
    corectrl # GPU configuration.
    openrgb-with-all-plugins # RGB control.
    pavucontrol # Audio devices configuration.
    helvum # Audio porting.
    fastfetch # Loonix redditing.
    linuxKernel.packages.linux_6_6.v4l2loopback # OBS virtual cam.

    # Wine and friends
    wine64Packages.stagingFull # Wine 64 bit tools.
    winePackages.stagingFull # Wine 32 bit tools.
    winetricks # Wine prefix editor.
    protontricks # Proton prefix editor.
    proton-caller # Proton updater.
    protonup # Proton GE.
    protonup-qt # Proton for easy apply to other apps.

    # Archive and Compression
    unrar # .rar files are fucking lame.
    p7zip # The GOAT.
  ];
}