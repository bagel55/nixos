{ config, pkgs, ... }:{
#User Config
  programs.zsh.enable = true;
  users.users.bagel = {
    isNormalUser = true;
    description = "bagel";
    extraGroups = [ "networkmanager" "wheel" "dialout" "input" ];
    useDefaultShell = true;
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Basic Applications
        alacritty #Terminal emulator.
        brave #Web browser.
        discord #Discord.
        spotify #Spotify.

      # Games
        lutris #Gaming prefix manager.
        bottles #Bulk gaming prefix manager.
        heroic-unwrapped #Epic and GOG prefix manager.
        xivlauncher #FFXIV dalamud launcher.
        prismlauncher #Minecraft launcher.

      # Game mode, cheats, or tools.
        gamemode #Optimizations for games.
        samrewritten
        r2modman #Mod stuffs for loads of games.
        fflogs #Not ego parsing.

      # Emulators
        rpcs3 #PS3.
        shadps4 #PS4.
        xemu #Original Xbox.
        ryujinx #Switch.
        retroarchFull #Most other emulators.

      # Studio
        onlyoffice-bin #Office suite.
        davinci-resolve #Premeir Pro & After effects.
        gimp #Photoshop.
        inkscape-with-extensions #Illistrator.
        drawing
        blender #3D model editor.
        audacity #Audio editor.
        obs-studio #OBS.
        linuxKernel.packages.linux_6_6.v4l2loopback #OBS virtual cam.
        kicad #PCB CAD. 
        unityhub #Game engine.
        godot #Other game engine.
    ];
  };

#Auto Login
  services.displayManager.autoLogin = {
    enable = true;
    user = "bagel";
  };
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  services.gnome.gnome-keyring.enable = true;
}