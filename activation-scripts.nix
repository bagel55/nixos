{ config, pkgs, ... }:{
system.activationScripts.nixos-permissions = {
  text = ''
    echo "[Permissions] Setting /etc/nixos group to wheel with write permissions"

    chown -R root:wheel /etc/nixos
    chmod -R g+rw /etc/nixos
    find /etc/nixos -type d -exec chmod g+s {} \;
  '';
};}
