{ config, pkgs, ... }:{
# flatpak + GNOME Software (core-apps is off in gnome.nix, so add it back here)
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [ gnome-software ];

# add remotes system-wide on boot (idempotent)
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    serviceConfig.Type = "oneshot";
    script = ''
      flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      flatpak remote-add --system --if-not-exists GeForceNOW https://international.download.nvidia.com/GFNLinux/flatpak/geforcenow.flatpakrepo
    '';
  };
}
