# Home clutter cleanup, runs on every rebuild:
#  - points apps at XDG dirs (~/.config, ~/.local/share, ~/.local/state, ~/.cache)
#    and moves their existing dotfiles there
#  - removes leftovers from desktop environments that aren't enabled
# Nothing is deleted outright: removed files go to the GNOME trash.
{ config, lib, pkgs, osConfig, ... }:
let
  inherit (config.xdg) configHome dataHome stateHome cacheHome;

  vars = {
    ANDROID_USER_HOME = "${dataHome}/android";
    DOTNET_CLI_HOME = "${dataHome}/dotnet";
    GTK2_RC_FILES = "${configHome}/gtk-2.0/gtkrc";
    XCOMPOSECACHE = "${cacheHome}/X11/xcompose";
    WINEPREFIX = "${dataHome}/wine";
    _Z_DATA = "${dataHome}/z";
  };

  # dotfile -> new location
  moves = {
    ".android" = "${dataHome}/android";
    ".dotnet" = "${dataHome}/dotnet/.dotnet"; # dotnet creates .dotnet inside DOTNET_CLI_HOME
    ".gitconfig" = "${configHome}/git/config";
    ".gtkrc-2.0" = "${configHome}/gtk-2.0/gtkrc";
    ".icons" = "${dataHome}/icons";
    ".pulse-cookie" = "${configHome}/pulse/cookie";
    ".wine" = "${dataHome}/wine";
    ".z" = "${dataHome}/z";
    ".p10k.zsh" = "${configHome}/zsh/.p10k.zsh";
    ".tmux/resurrect" = "${dataHome}/tmux/resurrect";
    ".nix-defexpr" = "${stateHome}/nix/defexpr";
    ".nix-profile" = "${stateHome}/nix/profile";
  };

  # history files: merged into the new file (old lines first)
  histories = {
    ".zsh_history" = "${stateHome}/zsh/history";
    ".bash_history" = "${stateHome}/bash/history";
  };

  # regenerated automatically, safe to bin
  junk = [ ".zcompdump*" ".compose-cache" ".tmux" ];

  # Desktop leftovers: each desktop's files are binned while none of its
  # NixOS options are enabled. Shared stuff (dconf, gtk-3.0/4.0, mimeapps) is never touched.
  desktops = {
    gnome = {
      options = [ "services.desktopManager.gnome.enable" ];
      files = [
        ".config/gnome-session" ".local/share/gnome-shell" ".local/share/gnome-settings-daemon"
        ".local/share/gnome-control-center" ".cache/gnome-*" ".cache/tracker3" ".local/share/tracker"
      ];
    };
    plasma = {
      options = [ "services.desktopManager.plasma6.enable" ];
      files = [
        ".config/kdeglobals" ".config/kdedefaults" ".config/kde.org" ".config/KDE"
        ".config/plasma*" ".config/kwin*" ".config/kglobalshortcutsrc" ".config/khotkeysrc"
        ".config/kded5rc" ".config/kded6rc" ".config/ksmserver*" ".config/kscreenlockerrc"
        ".config/ksplashrc" ".config/kcminputrc" ".config/kactivitymanagerd*" ".config/baloofilerc"
        ".config/kxkbrc" ".config/powermanagementprofilesrc" ".config/powerdevilrc"
        ".config/systemsettingsrc" ".config/krunnerrc" ".config/kwalletrc" ".config/kconf_updaterc"
        ".config/breezerc" ".config/kiorc" ".config/kservicemenurc" ".config/ktimezonedrc"
        ".config/kdeconnect" ".config/kaccessrc" ".config/kgammarc" ".config/klipperrc"
        ".config/bluedevilglobalrc" ".config/ktrashrc" ".config/kuriikwsfilterrc" ".config/kmixrc"
        ".config/spectaclerc" ".config/dolphinrc" ".config/konsolerc" ".config/katerc"
        ".config/kwriterc" ".config/gwenviewrc" ".config/okularrc" ".config/okularpartrc"
        ".config/arkrc" ".config/discoverrc" ".config/PlasmaDiscoverUpdates" ".config/Trolltech.conf"
        ".config/xsettingsd" ".config/kded_device_automounterrc" ".config/kcmfonts"
        ".config/kfontinstuirc" ".config/kmenueditrc"
        ".local/share/baloo" ".local/share/kactivitymanagerd" ".local/share/plasma*"
        ".local/share/kscreen" ".local/share/kwalletd" ".local/share/kded5" ".local/share/kded6"
        ".local/share/kxmlgui5" ".local/share/konsole" ".local/share/kwin" ".local/share/klipper"
        ".local/share/dolphin" ".local/share/RecentDocuments" ".local/share/systemsettings"
        ".local/share/kcookiejar" ".local/share/kservices5" ".local/share/kservices6"
        ".local/share/knewstuff3" ".local/share/kate" ".local/share/okular" ".local/share/user-places.xbel*"
        ".local/share/sddm" ".local/state/*staterc"
        ".cache/ksycoca*" ".cache/plasma*" ".cache/kwin" ".cache/krunner" ".cache/kioexec"
        ".cache/kscreen*" ".cache/icon-cache.kcache" ".cache/kcrash-metadata" ".cache/systemsettings"
        ".cache/org.kde.*" ".cache/kdeconnect*" ".cache/ksplash*" ".cache/kded*"
      ];
    };
    cosmic = {
      options = [ "services.desktopManager.cosmic.enable" ];
      files = [ ".config/cosmic*" ".local/state/cosmic*" ".local/share/cosmic*" ".cache/cosmic*" ];
    };
    xfce = {
      options = [ "services.xserver.desktopManager.xfce.enable" ];
      files = [ ".config/xfce4" ".config/Thunar" ".local/share/xfce4" ".cache/xfce4" ".cache/sessions" ];
    };
    cinnamon = {
      options = [ "services.xserver.desktopManager.cinnamon.enable" ];
      files = [ ".cinnamon" ".config/cinnamon*" ".config/nemo" ".local/share/cinnamon" ".local/share/nemo" ".cache/cinnamon" ];
    };
    mate = {
      options = [ "services.xserver.desktopManager.mate.enable" ];
      files = [ ".config/mate" ".config/mate-menu" ".config/caja" ".cache/mate*" ];
    };
    lxqt = {
      options = [ "services.xserver.desktopManager.lxqt.enable" ];
      files = [ ".config/lxqt" ".config/pcmanfm-qt" ".cache/lxqt*" ];
    };
    budgie = {
      options = [ "services.desktopManager.budgie.enable" ];
      files = [ ".config/budgie-desktop" ".config/budgie-extras" ".cache/budgie*" ];
    };
    pantheon = {
      options = [ "services.desktopManager.pantheon.enable" ];
      files = [ ".config/io.elementary*" ".local/share/io.elementary*" ".cache/io.elementary*" ];
    };
    hyprland = {
      options = [ "programs.hyprland.enable" ];
      files = [ ".config/hypr" ".local/share/hyprland" ".cache/hyprland" ];
    };
    sway = {
      options = [ "programs.sway.enable" ];
      files = [ ".config/sway" ];
    };
    niri = {
      options = [ "programs.niri.enable" ];
      files = [ ".config/niri" ];
    };
  };

  enabled = path: lib.attrByPath (lib.splitString "." path) false osConfig;
  deJunk = lib.concatLists (lib.mapAttrsToList
    (_: de: lib.optionals (!lib.any enabled de.options) de.files)
    desktops);

  q = lib.escapeShellArg;
in
{
  home.sessionVariables = vars;
  systemd.user.sessionVariables = vars; # GNOME session and apps launched from it

  home.activation.homeCleanup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    shopt -s nullglob dotglob

    bin() {
      local f
      for f in "$@"; do
        if [[ -e $f || -L $f ]]; then
          verboseEcho "cleanup: trashing $f"
          run env GIO_USE_VFS=local ${pkgs.glib}/bin/gio trash -- "$f" \
            || warnEcho "cleanup: could not trash $f"
        fi
      done
    }

    relocate() {
      local src=$HOME/$1 dest=$2
      [[ -e $src || -L $src ]] || return 0
      run mkdir -p "$(dirname "$dest")"
      if [[ ! -e $dest && ! -L $dest ]]; then
        verboseEcho "cleanup: moving $src -> $dest"
        run mv -T "$src" "$dest"
      elif [[ -d $src && -d $dest ]]; then
        run cp -a --update=none "$src/." "$dest/" && bin "$src"
      else
        warnEcho "cleanup: $src and $dest both exist, leaving $src alone"
      fi
    }

    mergeHistory() {
      local src=$HOME/$1 dest=$2
      [[ -f $src && ! -L $src ]] || return 0
      run mkdir -p "$(dirname "$dest")"
      if [[ -f $dest ]]; then
        run bash -c 'cat "$1" "$2" > "$2.merge" && mv "$2.merge" "$2"' _ "$src" "$dest" && bin "$src"
      else
        run mv "$src" "$dest"
      fi
    }

    ${lib.concatStrings (lib.mapAttrsToList (s: d: "relocate ${q s} ${q d}\n") moves)}
    ${lib.concatStrings (lib.mapAttrsToList (s: d: "mergeHistory ${q s} ${q d}\n") histories)}
    cd "$HOME"
    bin ${lib.concatStringsSep " " (junk ++ deJunk)}
    cd - >/dev/null

    shopt -u nullglob dotglob
  '';
}
