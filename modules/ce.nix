{ pkgs, ... }:

let
  ceProtonLauncherFhs = pkgs.buildFHSEnv {
    name = "ce-proton-launcher-fhs";
    targetPkgs = pkgs: with pkgs; [
      bash
      coreutils
      findutils
      gnugrep
      gawk
      gnused
      util-linux

      glib
      gtk2
      gtk3
      gdk-pixbuf
      zenity

      fontconfig
      freetype
      zlib
      openssl
      stdenv.cc.cc.lib

      xorg.libX11
      xorg.libXext
      xorg.libXrandr
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      xorg.libxcb

      vulkan-loader
      libglvnd

      steam
    ];
    runScript = "${pkgs.bash}/bin/bash";
  };

  ceProtonLauncherBin = "/home/bagel/Games/CEProtonLauncher";
  # change that path to wherever you keep the upstream binary
in
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = [
    ceProtonLauncherFhs

    (pkgs.writeShellApplication {
      name = "ce-proton-launcher";
      runtimeInputs = [ ceProtonLauncherFhs pkgs.coreutils ];
      text = ''
        set -euo pipefail

        if [ "$#" -lt 1 ]; then
          echo "usage: ce-proton-launcher <appid> [extra args...]" >&2
          exit 1
        fi

        if [ ! -x "${ceProtonLauncherBin}" ]; then
          echo "CEProtonLauncher not found or not executable at:" >&2
          echo "  ${ceProtonLauncherBin}" >&2
          exit 1
        fi

        exec ce-proton-launcher-fhs -c 'exec "$@"' _ \
          "${ceProtonLauncherBin}" "$@"
      '';
    })
  ];
}