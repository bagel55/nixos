{ pkgs, ... }:

let
  unityEditorFhs = pkgs.buildFHSEnv {
    name = "unity-editor-fhs";
    targetPkgs = pkgs: with pkgs; [
      alsa-lib
      atk
      cairo
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      harfbuzz
      libdrm
      libglvnd
      libpulseaudio
      libuuid
      libxkbcommon
      nspr
      nss
      pango
      stdenv.cc.cc.lib
      vulkan-loader
      xorg.libICE
      xorg.libSM
      xorg.libX11
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXtst
      xorg.libxcb
      xorg.libxshmfence
      zlib
      git
      curl
      icu
    ];
    runScript = "${pkgs.bash}/bin/bash";
  };
in
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "unity-vulkan";
      runtimeInputs = [ unityEditorFhs pkgs.findutils pkgs.coreutils ];
      text = ''
        set -euo pipefail

        base="$HOME/Unity/Hub/Editor"

        if [ ! -d "$base" ]; then
          echo "Unity editor directory not found: $base" >&2
          exit 1
        fi

        editor="$(
          find "$base" -type f -path "$base/*/Editor/Unity" \
            | sort -V \
            | tail -n1
        )"

        if [ -z "$editor" ]; then
          echo "No Unity editor found under $base" >&2
          exit 1
        fi

        cmd='exec "$@"'
        exec unity-editor-fhs -c "$cmd" _ \
          "$editor" \
          -force-vulkan \
          "$@"
      '';
    })
  ];
}