{ config, pkgs, ... }:{
# boot
	boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };
  boot.loader.efi.canTouchEfiVariables = true;

# Garbage
  nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 14d"; };
  boot.loader.grub.configurationLimit = 10;

# Kernel
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelModules = [ "ntsync" ]; # NT sync for Proton/Wine (MangoHud WSYNC shows NTsync)

# Compressed swap in RAM: under memory pressure, compress instead of freezing/killing apps
  zramSwap.enable = true;

# Run prebuilt Linux binaries (VS Code extensions, Unity/.NET tooling, downloads)
  programs.nix-ld.enable = true;

# SSD trim
	services.fstrim.enable = true;

# nixos configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true; # hard-link identical files in /nix/store
  hardware.enableAllFirmware = true;

# Appimages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

# dconf
  programs.dconf.enable = true;

# fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

# internationalisation properties
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

# networking
  networking.networkmanager.enable = true;
  networking.hosts = {
  "0.0.0.0" = [
      "paradise-s1.battleye.com"
      "test-s1.battleye.com"
      "paradiseenhanced-s1.battleye.com"
    ];
  };

# time zone
  time.timeZone = "America/Los_Angeles";

# Bluetooth
  hardware.bluetooth.enable = true;

# Logiperifs
  services.ratbagd.enable = true;

# sound
  services.pulseaudio.enable = false;
 	security.rtkit.enable = true;
 	services.pipewire = {
    enable = true;
	  alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
    jack.enable = true;
	};

# Podman
  virtualisation.podman.enable = true;

# auto login
  services.displayManager.autoLogin = {
    enable = true;
    user = "bagel";
  };
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}