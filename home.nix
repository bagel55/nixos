{ config, pkgs, lib, ... }: 
let
  repoDirTpm = "${config.home.homeDirectory}/.tmux/plugins/tpm";
  repoDirTkyo = "${config.home.homeDirectory}/.tmux/plugins/tokyo-night-tmux";
  gitPath = "${pkgs.git}/bin/git";
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
  shortcut = "a";

  baseIndex = 1;
  newSession = true;

  escapeTime = 0;

  secureSocket = false;

  plugins = with pkgs; [
    tmuxPlugins.tokyo-night-tmux
  ];

  extraConfig = ''
    unbind r
    bind r source-file ~/.tmux.conf

    set -g prefix C-s
    set -g mouse on

    set-option -g status-position top
    set-environment -gu "SSH_ASKPASS"
  '';
};

home.file = {
  ".config/alacritty/alacritty.toml".text = ''
    [window]
    opacity = 0.90
  '';
};

#home.activation.cloneRepoTpm = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
#  if [ ! -d "${repoDirTpm}" ]; then
#    echo "Cloning repo to ${repoDirTpm}..."
#    ${gitPath} clone https://github.com/tmux-plugins/tpm "${repoDirTpm}"
#  else
#    echo "Repo already exists at ${repoDirTpm}"
#  fi
#'';

#home.activation.cloneRepoTkyo = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
#  if [ ! -d "${repoDirTkyo}" ]; then
#    echo "Cloning repo to ${repoDirTkyo}..."
#    ${gitPath} clone https://github.com/janoamaral/tokyo-night-tmux "${repoDirTkyo}"
#  else
#    echo "Repo already exists at ${repoDirTkyo}"
#  fi
#'';

home.stateVersion = "25.05";
}
