{ config, pkgs, ... }:{
# Flatpak, only for apps nixpkgs doesn't have (Brave was dropped from nixpkgs 2026-11)
  services.flatpak.enable = true;

# add Flathub and install/update the apps on boot and daily (idempotent)
  systemd.services.flatpak-apps = {
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    serviceConfig.Type = "oneshot";
    startAt = "daily";
    script = ''
      flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      flatpak install --system --noninteractive --or-update flathub com.brave.Browser
      flatpak update --system --noninteractive
    '';
  };
}
