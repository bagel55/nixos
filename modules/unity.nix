{ pkgs, ... }:

let
  unityEditorFhs = pkgs.buildFHSEnv {
    name = "unity-editor-fhs";
    targetPkgs = pkgs: with pkgs; [
      alsa-lib
      atk
      cairo
      curl
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      git
      glib
      gtk3
      harfbuzz
      icu
      openssl
      libdrm
      libglvnd
      libpulseaudio
      libuuid
      libxkbcommon
      libxml2_13
      nspr
      nss
      pango
      stdenv.cc.cc.lib
      systemd
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
          -force-glcore \
          "$@"
      '';
    })
  ];
}