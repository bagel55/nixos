{ config, pkgs, ... }:{
# Flatpak, only for apps nixpkgs doesn't have (Brave was dropped from nixpkgs 2026-11)
  services.flatpak.enable = true;
}
