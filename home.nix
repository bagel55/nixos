{ config, pkgs, ... }: {
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
};

programs.tmux = {
  enable = true;
  extraConfig = ''
    unbind r
    bind r source-file ~/.tmux.conf

    set -g prefix C-s
    set -g mouse on

    set-option -g status-position top
    set-environment -gu "SSH_ASKPASS"

    # List of plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'janoamaral/tokyo-night-tmux'

    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    run '~/.tmux/plugins/tpm/tpm'
  '';
};

home.stateVersion = "25.05";
}