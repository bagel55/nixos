{ pkgs, ... }:

let
  unityEditorFhs = pkgs.buildFHSEnv {
    name = "unity-editor-fhs";

    targetPkgs = pkgs: with pkgs; [
      # Core
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
      zlib

      # Minimal X11 (required even on Wayland/XWayland)
      xorg.libX11
      xorg.libxcb
      xorg.libXcursor
      xorg.libXi
      xorg.libXrandr

      # Wayland + GPU stack (important)
      wayland
      wayland-protocols
      libgbm

      # Desktop integration
      libnotify
      libsecret
      at-spi2-core
      gsettings-desktop-schemas
      hicolor-icon-theme

      # Fonts (critical)
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];

    runScript = "${pkgs.bash}/bin/bash";
  };

  unityLauncher = pkgs.writeShellApplication {
    name = "unity-base";

    runtimeInputs = [
      unityEditorFhs
      pkgs.findutils
      pkgs.coreutils
    ];

    text = ''
      set -euo pipefail

      base="$HOME/Unity/Hub/Editor"

      # Extract -projectPath argument
      project=""
      prev=""

      for arg in "$@"; do
        if [ "$prev" = "-projectPath" ]; then
          project="$arg"
          break
        fi
        prev="$arg"
      done

      # Normalize path (helps with relative paths)
      if [ -n "$project" ]; then
        project="$(realpath "$project")"
      fi

      # Priority:
      # 1. UNITY_VERSION (manual override)
      # 2. ProjectVersion.txt (auto-detect)
      # 3. Latest installed

      version="''${UNITY_VERSION:-}"

      if [ -z "$version" ] && [ -n "$project" ] && [ -f "$project/ProjectSettings/ProjectVersion.txt" ]; then
        version="$(
          grep m_EditorVersion "$project/ProjectSettings/ProjectVersion.txt" \
            | awk '{print $2}'
        )"
      fi

      if [ -n "$version" ]; then
        editor="$base/$version/Editor/Unity"
      else
        editor="$(
          find "$base" -type f -path "$base/*/Editor/Unity" \
            | sort -V \
            | tail -n1
        )"
      fi

      if [ ! -x "$editor" ]; then
        echo "Unity editor not found: $editor" >&2
        exit 1
      fi

      export XDG_DATA_DIRS=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS

      ulimit -n 4096 || true

      # NVIDIA mitigation (safe to keep)
      export __GL_THREADED_OPTIMIZATIONS=0
      export __GL_SYNC_TO_VBLANK=1

      exec unity-editor-fhs -c 'exec "$@"' _ "$editor" "$@"
    '';
};

in
{
  environment.systemPackages = [

    unityLauncher

    (pkgs.writeShellApplication {
    name = "unity-vulkan";
    runtimeInputs = [ unityLauncher ];
    text = ''
      # Vulkan / sync related fixes
      export MESA_VK_WSI_PRESENT_MODE=immediate
      export vblank_mode=0

      # NVIDIA only (safe to leave, ignored on AMD/Intel)
      export __GL_SYNC_TO_VBLANK=0
      export __GL_MaxFramesAllowed=1

      exec unity-base -force-vulkan "$@"
    '';
  })

    (pkgs.writeShellApplication {
      name = "unity-gl";
      runtimeInputs = [ unityLauncher ];
      text = ''
        exec unity-base -force-glcore "$@"
      '';
    })

    (pkgs.writeShellApplication {
      name = "unity-steam";
      runtimeInputs = [ pkgs.steam-run pkgs.findutils pkgs.coreutils ];
      text = ''
        base="$HOME/Unity/Hub/Editor"

        editor="$(
          find "$base" -type f -path "$base/*/Editor/Unity" \
            | sort -V \
            | tail -n1
        )"

        exec steam-run "$editor" -force-vulkan "$@"
      '';
    })
  ];
}