# Shell: zsh + oh-my-zsh + Powerlevel10k, tmux, direnv
{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    # keep zsh files out of ~ (only ~/.zshenv stays, it points here)
    dotDir = "${config.xdg.configHome}/zsh";
    history.path = "${config.xdg.stateHome}/zsh/history";
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "tmux" "direnv" ];
      extraConfig = ''
        ZSH_COMPDUMP="${config.xdg.cacheHome}/zsh/zcompdump-$ZSH_VERSION"
      '';
    };
    # mkAfter: keep this block last in .zshrc (after the direnv hook)
    initContent = lib.mkAfter ''
      # use 'p10k configure'
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ${config.programs.zsh.dotDir}/.p10k.zsh ]] && source ${config.programs.zsh.dotDir}/.p10k.zsh

      if command -v tmux >/dev/null && [ -z "$TMUX" ]; then
        exec tmux new-session -A -s main
      fi
    '';
  };

  xdg.cacheFile."zsh/.keep".text = ""; # dir for ZSH_COMPDUMP

  programs.tmux = {
    enable = true;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;

    plugins = with pkgs.tmuxPlugins; [
      tokyo-night-tmux
      continuum
      resurrect
    ];

    extraConfig = ''
      set -g prefix C-s
      set -g mouse on

      set-environment -gu "SSH_ASKPASS"

      unbind h
      bind h split-window -h -c "#{pane_current_path}"

      unbind v
      bind v split-window -v -c "#{pane_current_path}"

      set -g @tokyo-night-tmux_show_netspeed 1

      set -g @continuum-restore 'on'
      set -g @resurrect-capture-pane-contents 'on'
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
