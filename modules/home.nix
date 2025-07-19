{ config, pkgs, lib, ... }: {
# Enables home-manager
home.username = "bagel";
home.homeDirectory = "/home/bagel";
programs.home-manager.enable = true;

# Enables and configures both zsh and oh-my-zsh
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "tmux" "direnv" ];
    };
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      if command -v tmux >/dev/null; then
        if [ -z "$TMUX" ]; then
        # Attach to existing session or create one named 'main'
        tmux attach-session -t main 2>/dev/null || tmux new-session -s main
        fi
      fi
    '';
  };

# Enable direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;


# Enables and configures tmux
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
    '';
  };

# Configures Alacritty
  home.file = {
    ".config/alacritty/alacritty.toml".text = ''
      [window]
      opacity = 0.90
      dimensions = { columns = 120, lines = 40 }

      [terminal.shell]
      program = "tmux"
      args = ["new-session", "-A", "-s", "main"]

      [colors.primary]
      background = "#1a1b26"
      foreground = "#c0caf5"

      [colors.normal]
      black   = "#15161E"
      red     = "#f7768e"
      green   = "#9ece6a"
      yellow  = "#e0af68"
      blue    = "#7aa2f7"
      magenta = "#bb9af7"
      cyan    = "#7dcfff"
      white   = "#a9b1d6"

      [colors.bright]
      black   = "#414868"
      red     = "#f7768e"
      green   = "#9ece6a"
      yellow  = "#e0af68"
      blue    = "#7aa2f7"
      magenta = "#bb9af7"
      cyan    = "#7dcfff"
      white   = "#c0caf5"
    '';
  };

home.stateVersion = "25.05";
}
