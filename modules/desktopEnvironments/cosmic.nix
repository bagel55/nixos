{ config, pkgs, ... }: {
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.cosmic.xwayland.enable = true;

  # Exclude packages you don’t want
  environment.cosmic.excludePackages = with pkgs; [
    # Examples of things people commonly remove:
    # cosmic-edit          # text editor
    # cosmic-files         # file manager (careful – can break session if removed alone)
    # cosmic-term          # terminal
    # cosmic-player        # media player
    # cosmic-store         # app store (only useful if you use Flatpak)
    # cosmic-wallpapers
  ];

  # Extra packages you actually want
  environment.systemPackages = with pkgs; [
    cosmic-screenshot
  ];
}