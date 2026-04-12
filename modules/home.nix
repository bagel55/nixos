{ config, pkgs, lib, ... }: {
# enables home-manager
  home.enableNixpkgsReleaseCheck = false;
  home.username = "bagel";
  home.homeDirectory = "/home/bagel";
  programs.home-manager.enable = true;

# alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.90;
        dimensions = { columns = 120; lines = 40; };
      };
      colors = {
        primary = {
          background = "#1a1b26";
          foreground = "#c0caf5";
        };
        normal = {
          black = "#15161E";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
        };
        bright = {
          black = "#414868";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#c0caf5";
        };
      };
    };
  };

# zsh and oh-my-zsh
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "tmux" "direnv" ];
    };
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      if command -v tmux >/dev/null && [ -z "$TMUX" ]; then
        exec tmux new-session -A -s main
      fi
    '';
  };

# tmux
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

# Mango Hud
  programs.mangohud = {
    settings = {
      no_display = true;
      
      ### Core
      fps = true;
      frametime = true;
      frame_timing = true;

      ### GPU
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_power = true;
      gpu_load_change = true;
      vram = true;

      ### CPU
      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      cpu_mhz = true;

      ### Memory
      ram = true;
      swap = true;

      ### System info
      engine_version = true;
      vulkan_driver = true;
      arch = true;
      wine = true;

      ### Frame pacing / diagnostics
      throttling_status = true;
      device_battery = true;
      io_read = true;
      io_write = true;

      ### FPS limits / sync info
      fps_limit_method = "early";
      vsync = true;

      ### Layout
      position = "top-left";
      font_size = 20;
      background_alpha = 0.4;
      round_corners = 5;

      ### Graphs
      cpu_load_change = true;
      fps_color_change = true;

      ### Colors (optional but useful)
      gpu_color = "2E9762";
      cpu_color = "2E97CB";
      vram_color = "AD64C1";
      ram_color = "C26693";

      ### Other nice extras
      gamemode = true;
      resolution = true;
      fps_only = false;
    };
  };

# gnome font
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "JetBrainsMono Nerd Font 11";
      document-font-name = "JetBrainsMono Nerd Font 11";
      monospace-font-name = "JetBrainsMono Nerd Font Mono 11";
    };
  };

  programs.gnome-shell.extensions = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    just-perfection
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "just-perfection-desktop@just-perfection"
      ];
    };
  };

# direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

home.stateVersion = "25.11";
}
