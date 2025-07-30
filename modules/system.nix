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
  
# SSD trim
	services.fstrim.enable = true;

# nixos configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

# time zone
  time.timeZone = "America/Los_Angeles";

# sound
  hardware.bluetooth.enable = true;
  services.pulseaudio.enable = false;
 	security.rtkit.enable = true;
 	services.pipewire = {
    enable = true;
	  alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
    jack.enable = true;
    extraConfig.pipewire-pulse = {
      "10-disable-agc-chrome" = {
        pulse.rules = [ {
          matches = [
            { "application.process.binary" = "Vesktop"; }
            { "application.process.binary" = "Discord"; }
            { "application.process.binary" = "chromium"; }
            { "application.process.binary" = "chrome"; }
          ];
          actions = {
            quirks = [ "block-source-volume" ];
          };
        }];
      };
    };
	};

# auto login
  services.displayManager.autoLogin = {
    enable = true;
    user = "bagel";
  };
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

# fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}