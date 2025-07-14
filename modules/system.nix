{ config, pkgs, ... }:
let
  no-rgb = pkgs.writeScriptBin "no-rgb" ''
    #!/bin/sh
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)

    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode static --color 000000
    done
  '';
in {
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

# OpenRGB
  services.hardware.openrgb.enable = true;
  services.udev.packages = [ pkgs.openrgb ];
  boot.kernelModules = [ 
    "i2c-dev"
    "i2c-i801"
    "i2c-piix4"
  ];
  hardware.i2c.enable = true;

  systemd.services.no-rgb = {
    description = "no-rgb";
    serviceConfig = {
      ExecStart = "${no-rgb}/bin/no-rgb";
      Type = "oneshot";
    };
    wantedBy = [ "multi-user.target" ];
  };

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

    # Wine
    wine64Packages.stagingFull # Wine 64 bit tools.
    winePackages.stagingFull # Wine 32 bit tools.
    winetricks # Wine prefix editor.

    # Archive and Compression
    unrar # .rar files are fucking lame.
    p7zip # The GOAT.
  ];
}