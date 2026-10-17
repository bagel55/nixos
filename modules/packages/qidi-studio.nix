# QIDI Studio (Plus5 support), packaged from the upstream AppImage.
# nixpkgs has the same version as pkgs.qidi-studio, but without libsoup_3;
# switch to it once nixpkgs adds that (or if it works without it for you).
{ pkgs }:

let
  pname = "qidi-studio";
  version = "2.07.02.60";

  src = pkgs.fetchurl {
    url = "https://github.com/QIDITECH/QIDIStudio/releases/download/v${version}/QIDIStudio_v0${version}_Ubuntu24.AppImage";
    hash = "sha256-1H0rLI3V8W1I+KIbolQg/Wat9WsACMy1RIdyU0s8seg=";
  };

  contents = pkgs.appimageTools.extract { inherit pname version src; };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = p: [
    p.webkitgtk_4_1
    p.libsoup_3
  ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  extraInstallCommands = ''
    install -m 444 -D \
      ${contents}/QIDIStudio.desktop \
      $out/share/applications/QIDIStudio.desktop

    install -m 444 -D \
      ${contents}/QIDIStudio.png \
      $out/share/icons/hicolor/scalable/apps/QIDIStudio.png

    substituteInPlace \
      $out/share/applications/QIDIStudio.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=qidi-studio'

    wrapProgram "$out/bin/qidi-studio" \
      --set-default WEBKIT_DISABLE_COMPOSITING_MODE 0 \
      --set-default WEBKIT_DISABLE_DMABUF_RENDERER 0
  '';
}
