{ config, pkgs, lib, ... }: 
let
  repoDirTpm = "${config.home.homeDirectory}/.tmux/plugins/tpm";
  repoDirTkyo = "${config.home.homeDirectory}/.tmux/plugins/tokyo-night-tmux";
  gitPath = "${pkgs.git}/bin/git";

  tmuxConf = ''
    unbind r
    bind r source-file ~/.tmux.conf

    set -g prefix C-s
    set -g mouse on

    set-option -g status-position top
    set-environment -gu "SSH_ASKPASS"

    # List of plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin "janoamaral/tokyo-night-tmux"
    set -g @tokyo-night-tmux_theme storm

    # Other examples:
    # set -g @plugin 'github_username/plugin_name'
    # set -g @plugin 'github_username/plugin_name#branch'
    # set -g @plugin 'git@github.com:user/plugin'
    # set -g @plugin 'git@bitbucket.com:user/plugin'

    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    run '~/.tmux/plugins/tpm/tpm'
  '';

  tmuxConfPath = "${config.home.homeDirectory}/.tmux.conf";
in 
{
home.username = "bagel";
home.homeDirectory = "/home/bagel";

programs.home-manager.enable = true;

programs.zsh = {
  enable = true;
  oh-my-zsh = {
    enable = true;
    theme = "jonathan";
    plugins = [ "git" "z" "tmux" ];
  };
  #initContent = ''
    #if [ -z "$TMUX" ] && command -v tmux >/dev/null; then
      #exec tmux
    #fi
  #'';
};

programs.tmux = {
  enable = true;
};

home.file = {
  ".config/alacritty/alacritty.toml".text = ''
    [window]
    opacity = 0.90
  '';
};

home.activation.writeTmuxConf = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo '${tmuxConf}' > ${tmuxConfPath}
    #chown ${config.home.username}:${config.home.username} ${tmuxConfPath}
  '';

home.activation.cloneRepoTpm = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  if [ ! -d "${repoDirTpm}" ]; then
    echo "Cloning repo to ${repoDirTpm}..."
    ${gitPath} clone https://github.com/tmux-plugins/tpm "${repoDirTpm}"
  else
    echo "Repo already exists at ${repoDirTpm}"
  fi
'';

home.activation.cloneRepoTkyo = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  if [ ! -d "${repoDirTkyo}" ]; then
    echo "Cloning repo to ${repoDirTkyo}..."
    ${gitPath} clone https://github.com/janoamaral/tokyo-night-tmux "${repoDirTkyo}"
  else
    echo "Repo already exists at ${repoDirTkyo}"
  fi
'';

home.stateVersion = "25.05";
}
