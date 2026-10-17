# GNOME: extensions and fonts (the fonts themselves are installed in system.nix)
{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  # installs the extensions and enables them (also writes enabled-extensions)
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = appindicator; }
      { package = blur-my-shell; }
      { package = just-perfection; }
      { package = tiling-shell; }
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "TeX Gyre Heros 12";
      document-font-name = "TeX Gyre Heros 12";
      monospace-font-name = "OpenDyslexicM Nerd Font Mono 12";
    };

    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "TeX Gyre Heros Bold 12";
    };
  };
}
