{
  config,
  pkgs,
  ...
}: {
  home.username = "jacob";
  home.homeDirectory = "/home/jacob";
  home.stateVersion = "25.11";

  # Environment Variables
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    GPG_TTY = "$(tty)";

    # XDG & Desktop
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CURRENT_DESKTOP = "Hyprland";

    # App specific
    AWS_PROFILE = "caesari-authentik-saml";
  };

  # Path Exports
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
  ];

  # Packages
  home.packages = with pkgs; [
    gh
    discord
    ghostty
    waybar
    swww
    vicinae
    google-chrome
    stow
    yazi
    rustup
    alejandra
  ];

  programs.tmux = {
    enable = true;
    shortcut = "a"; # Replaces 'set -g prefix C-a'
    baseIndex = 1; # Replaces 'set -g base-index 1'
    newSession = true; # Spawns a session if one doesn't exist
    escapeTime = 0; # Replaces 'set -sg escape-time 0'
    mouse = true; # Replaces 'set -g mouse on'

    # This handles the plugin AND the 'run-shell' logic automatically
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];

    extraConfig = ''
      # Terminal & Colors
      set -g default-terminal 'tmux-256color'
      set-option -sa terminal-features ',xterm-256color:RGB'
      set-option -g focus-events on

      # Bind å to enter copy-mode
      unbind [
      bind-key å copy-mode

      # Split windows & open in current path
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Vim-like pane switching
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      # Vim-like pane resizing
      bind -r C-k resize-pane -U 5
      bind -r C-j resize-pane -D 5
      bind -r C-h resize-pane -L 5
      bind -r C-l resize-pane -R 5

      # Maximise pane
      bind -r m resize-pane -Z

      # --- UI / Status Line (Monochrome Style) ---
      set-option -g status-position top
      set -g status-bg black
      set -g status-fg white
      set -g status-left ""
      set -g status-right " #h: #S "

      set -g status-justify left
      set-window-option -g window-status-separator ""
      set-window-option -g window-status-format "#[bg=black,fg=white] #I #W "
      set-window-option -g window-status-current-format "#[bg=brightblack,fg=brightwhite] #I #W "

      # Pane borders & Style
      set -g window-style "bg=default,fg=white"
      set -g window-active-style "bg=default,fg=brightwhite"
      set -g pane-border-style "bg=default,fg=black"
      set -g pane-active-border-style "bg=default,fg=black"
    '';
  };

  # Fish
  programs.fish = {
    enable = true;
    shellAliases = {
      kc = "kubectl";
      vim = "nvim";
      bt = "bluetuith";
      lsa = "ls -a";
    };
    interactiveShellInit = ''
      fish_vi_key_bindings
      set -g fish_greeting ""
    '';
    plugins = [
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "nvm";
        src = pkgs.fishPlugins.nvm.src;
      }
    ];
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      # Gruvbox Dark Palette colors
      # bg0: #282828, red: #fb4934, green: #b8bb26, yellow: #fabd2f, blue: #83a598

      format = "$directory$git_branch$git_status$nix_shell$character";

      directory = {
        style = "bold #83a598"; # Gruvbox Blue
      };

      git_branch = {
        symbol = " ";
        style = "bold #fb4934"; # Gruvbox Red
      };

      git_status = {
        style = "bold #fabd2f"; # Gruvbox Yellow
      };

      character = {
        success_symbol = "[➜](bold #b8bb26)"; # Gruvbox Green
        error_symbol = "[➜](bold #fb4934)"; # Gruvbox Red
      };
    };
  };

  # Git
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "jlodenius";
        email = "jacoblodenius@gmail.com";
      };
      init.defaultBranch = "master";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = ["--cmd cd"];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
