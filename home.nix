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
    # Auto-start tmux if not already inside a session
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
    set -g @plugin 'tokyo-night-tmux'
    set -g @tokyo-night-tmux-theme 'storm'

    run '~/.tmux/plugins/tpm/tpm'
  '';

  ".tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tpm";
    rev = "master";
    sha256 = "sha256-hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
  };

  ".tmux/plugins/tokyo-night-tmux".source = pkgs.fetchFromGitHub {
  owner = "janoamaral";
  repo = "tokyo-night-tmux";
  rev = "master";
  sha256 = "sha256-hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
  };
};

home.activation.installTmuxPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  if [ -n "$DISPLAY" ] || [ -n "$TMUX" ]; then
    echo "Installing tmux plugins..."
    ${pkgs.tmux}/bin/tmux start-server \; \
      run-shell ~/.tmux/plugins/tpm/bin/install_plugins || true
  fi
'';

home.stateVersion = "25.05";
}