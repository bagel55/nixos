{ config, pkgs, lib, ... }: {
home.username = "bagel";
home.homeDirectory = "/home/bagel";

programs.home-manager.enable = true;

programs.zsh = {
  enable = true;
  oh-my-zsh = {
    enable = true;
    theme = "jonathan";
    plugins = [ "git" "z" ];
  };
  initContent = ''
    if [ -z "$TMUX" ] && command -v tmux >/dev/null; then
      exec tmux
    fi
  '';
};

programs.tmux = {
  enable = true;
};

home.file = {
  ".tmux.conf".text = ''
    unbind r
    bind r source-file ~/.tmux.conf

    set -g prefix C-s
    set -g mouse on

    set-option -g status-position top
    set-environment -gu "SSH_ASKPASS"

    # List of plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin "janoamaral/tokyo-night-tmux"

    # Other examples:
    # set -g @plugin 'github_username/plugin_name'
    # set -g @plugin 'github_username/plugin_name#branch'
    # set -g @plugin 'git@github.com:user/plugin'
    # set -g @plugin 'git@bitbucket.com:user/plugin'

    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    run '~/.tmux/plugins/tpm/tpm'
  '';
};

home.file = {
  ".tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
  owner = "tmux-plugins";
  repo = "tpm";
  rev = "master";
  sha256 = "sha256-hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
  };
};

home.file = {
  ".tmux/plugins/tokyo-night-tmux".source = pkgs.fetchFromGitHub {
  owner = "janoamaral";
  repo = "tokyo-night-tmux";
  rev = "master";
  sha256 = "sha256-TOS9+eOEMInAgosB3D9KhahudW2i1ZEH+IXEc0RCpU0=";
  };
};

home.activation.installTmuxPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  if [ -n "$DISPLAY" ] || [ -n "$TMUX" ]; then
    echo "Installing tmux plugins..."
    ${pkgs.tmux}/bin/tmux start-server \; \
      run-shell ~/.tmux/plugins/tpm/bin/install_plugins || true
  fi
'';

xdg.configFile."alacritty/alacritty.toml".text = ''
  [window]
  opacity = 0.85  # 1.0 = opaque, 0.0 = fully transparent
  blur = true     # Enable background blur if supported by your compositor (e.g., picom)

  [font]
  normal.family = "JetBrainsMono Nerd Font"
  size = 11.0

  [colors]
  # Optional: make background fully black (transparency makes it subtle)
  [colors.primary]
  background = "0x000000"
  foreground = "0xdcd7ba"
'';

services.picom.enable = true;
services.picom.settings = {
  blur-background = true;
  opacity-rule = ["90:class_g = 'Alacritty'"];
};

home.stateVersion = "25.05";
}