{ config, pkgs, ... }:

let
  sshPath = "${pkgs.openssh}/bin/ssh";
  gitPath = "${pkgs.git}/bin/git";
  nixEnv = "${pkgs.nix}/bin/nix-env";
  alacarteDir = "/etc/nixos/alacarte";
  userName = "bagel";
  userHome = "/home/${userName}";
in {
systemd.services.git-pull-on-boot = {
  description = "Fetch and pull latest NixOS config on boot";
  wantedBy = [ "multi-user.target" ];
  after = [ "network-online.target" "NetworkManager-wait-online.service" ];
  requires = [ "network-online.target" "NetworkManager-wait-online.service" ];

  serviceConfig = {
    Type = "oneshot";
    Environment = ''
      GIT_SSH_COMMAND=${sshPath} -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes
      PATH=/run/current-system/sw/bin:/usr/bin:/bin
    '';
    ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
    ExecStart = pkgs.writeShellScript "git-pull-on-boot" ''
    LOGFILE="/etc/nixos/debug/git-pull-on-boot.log"
    rm -f "$LOGFILE"
    {
      echo "[INFO] Starting git fetch + pull at $(date)"
      cd /etc/nixos || { echo "[ERROR] Could not cd into /etc/nixos"; exit 0; }

      echo "RESOLV CONF:"
      cat /etc/resolv.conf

      # Capture current HEAD before fetch
      OLD_REV=$(${gitPath} rev-parse HEAD)

      ${gitPath} fetch origin main
      ${gitPath} reset --hard origin/main

      # Capture new HEAD after reset
      NEW_REV=$(${gitPath} rev-parse HEAD)

      REBUILD="/run/current-system/sw/bin/nixos-rebuild"
      CONFIG="/etc/nixos/configuration.nix"

      if [[ "$NEW_COMMIT" != "$OLD_COMMIT" ]]; then
        echo "[INFO] Changes detected. Rebuilding system..." >> "$LOGFILE"
        "$REBUILD" switch -I nixos-config="$CONFIG" >> "$LOGFILE" 2>&1
        echo "$NEW_COMMIT" > "$OLD_COMMIT_FILE"
        echo "[INFO] Rebuild complete." >> "$LOGFILE"
      fi

      echo "[INFO] Git fetch + pull complete"
    } >> "$LOGFILE" 2>&1
    '';
    User = "root";
    RemainAfterExit = true;

    # These lines make failure non-fatal to boot
    SuccessExitStatus = [ 0 1 ];
    StandardOutput = "journal";
    StandardError = "journal";
  };
};

systemd.services.restoreAlacarte = {
    description = "Restore Alacarte configuration for user ${userName}";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" "git-pull-on-boot.service" "network-online.target" "NetworkManager-wait-online.service"];
    requires = [ "git-pull-on-boot.service" "network-online.target" "NetworkManager-wait-online.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "restore-alacarte" ''
        set -e
        echo "[alacarte] Restoring Alacarte configuration for ${userName}"

        # Create target directories if missing
        mkdir -p ${userHome}/.local/share/applications
        mkdir -p ${userHome}/.config/menus
        mkdir -p ${userHome}/Pictures/Logos

        # Restore .desktop files
        cp -r ${alacarteDir}/applications/* ${userHome}/.local/share/applications/ 2>/dev/null || true

        # Restore menu layout
        cp ${alacarteDir}/menus/gnome-applications.menu ${userHome}/.config/menus/ 2>/dev/null || true

        # Restore custom icon images
        cp -r ${alacarteDir}/logos/* ${userHome}/Pictures/Logos/ 2>/dev/null || true

        # Set correct ownership
        chown -R ${userName}:users ${userHome}/.local/share/applications
        chown ${userName}:users ${userHome}/.config/menus/gnome-applications.menu
        chown -R ${userName}:users ${userHome}/Pictures/Logos
      '';
    };
  };

system.activationScripts.alacarteSync = ''
    echo "[alacarte] Saving Alacarte configuration to ${alacarteDir}"

    mkdir -p ${alacarteDir}/applications
    mkdir -p ${alacarteDir}/menus
    mkdir -p ${alacarteDir}/logos

    # Save all custom .desktop launchers
    cp -r --no-preserve=ownership ${userHome}/.local/share/applications/* ${alacarteDir}/applications/ 2>/dev/null || true

    # Save only the GNOME app menu structure file
    cp --no-preserve=ownership ${userHome}/.config/menus/gnome-applications.menu ${alacarteDir}/menus/ 2>/dev/null || true

    # Save all icons from Pictures/Logos
    cp -r --no-preserve=ownership ${userHome}/Pictures/Logos/* ${alacarteDir}/logos/ 2>/dev/null || true
'';

systemd.services.git-push-on-rebuild = {
  description = "Push latest NixOS config after rebuild";

  serviceConfig = {
    Type = "oneshot";
    Environment = ''
      GIT_SSH_COMMAND=${sshPath} -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes
      PATH=/run/current-system/sw/bin:/usr/bin:/bin
    '';
    ExecStart = pkgs.writeShellScript "git-push-on-rebuild" ''
      LOGFILE="/etc/nixos/debug/git-push-on-rebuild.log"
      rm -f "$LOGFILE"

      {
        echo "[INFO] Starting Git push at $(date)"
        cd /etc/nixos

        ${gitPath} config user.name "bagel"
        ${gitPath} config user.email "bagel2255@protonmail.com"

        ${gitPath} add .
        ${gitPath} commit -m "Auto backup on $(date '+%Y-%m-%d %H:%M:%S')" || echo "[INFO] Nothing to commit"
        ${gitPath} push origin main || echo "[WARN] Git push failed"

        echo "[INFO] Push complete at $(date)"
      } >> "$LOGFILE" 2>&1
    '';
    User = "root";
    SuccessExitStatus = [ 0 1 ];
    StandardOutput = "journal";
    StandardError = "journal";
  };
};

# Add an activation script to start it
system.activationScripts.gitPushOnRebuild = {
  text = ''
    echo "[INFO] Triggering git-push-on-rebuild.service"
    /run/current-system/systemd/bin/systemctl start git-push-on-rebuild.service
  '';
};


system.activationScripts.gc-keep-last-5 = {
  text = ''
    echo "[GC] Deleting all but the last 5 generations..."
    ${nixEnv} --delete-generations +5 --profile /nix/var/nix/profiles/system
  '';
};
}
