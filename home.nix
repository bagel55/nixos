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
  initContent = ''
    if [ -z "$TMUX" ] && command -v tmux >/dev/null; then
      exec tmux
    fi
  '';
};

programs.tmux = {
  enable = true;
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

    bind | split-window -h -c "#{pane_current_path}"
    bind - split-window -v -c "#{pane_current_path}"
  '';
};

home.file = {
  ".config/alacritty/alacritty.toml".text = ''
    [window]
    opacity = 0.90
  '';
};

home.stateVersion = "25.05";
}
