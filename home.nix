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
    if command -v tmux >/dev/null; then
      if [ -z "$TMUX" ]; then
      # Attach to existing session or create one named 'main'
      tmux attach-session -t main 2>/dev/null || tmux new-session -s main
      fi
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
    set -g prefix C-s
    set -g mouse on

    set-option -g status-position top
    set-environment -gu "SSH_ASKPASS"

    unbind h
    bind h split-window -h -c "#{pane_current_path}"

    unbind v
    bind v split-window -v -c "#{pane_current_path}"

    set -g @tokyo-night-tmux_show_time 0
    set -g @tokyo-night-tmux_show_date 0

    set -g @tokyo-night-tmux_show_netspeed 1
    set -g @tokyo-night-tmux_netspeed_refresh 1     # Update interval in seconds (default 1)

    set -g @tokyo-night-tmux_show_path 1
    set -g @tokyo-night-tmux_path_format relative # 'relative' or 'full'
  '';
};

home.file = {
  ".config/alacritty/alacritty.toml".text = ''
    [window]
    opacity = 0.90
    dimensions = { columns = 120, lines = 40 }
  '';
};

home.stateVersion = "25.05";
}
