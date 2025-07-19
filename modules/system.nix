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

# Auto Login
  services.displayManager.autoLogin = {
    enable = true;
    user = "bagel";
  };
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

# Nixos Configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# OpenRGB
  services.hardware.openrgb.enable = true;
}