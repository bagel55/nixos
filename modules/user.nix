{ config, pkgs, ... }:{
# user config
  programs.zsh.enable = true;
  users.users.bagel = {
    isNormalUser = true;
    description = "bagel";
    extraGroups = [ "networkmanager" "wheel" "dialout" "input" "kvm" "docker" ];
    useDefaultShell = true;
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Gnome apps
        gnome-shell-extensions
        gnome-tweaks
        gnome-themes-extra
        gnome-disk-utility
        gnome-logs
        snapshot
        alacarte # gnome menu editor
        baobab # disk analyser
        gnome-calculator
        nautilus # file explorer
        gnome-text-editor
        eog # images
        totem # videos
        evince # documents

      # basic applications
        alacritty 
        brave
        discord
        vesktop
        prismlauncher
        xivlauncher

      # proton
        protontricks
        proton-caller
        protonup

      # Studio
        onlyoffice-bin
        obs-studio
        dotnet-sdk
        unityhub
        github-desktop
        gimp
        vscode
    ];
  };
}

