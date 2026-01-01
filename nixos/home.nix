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

      # Disable the greeting
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

  # Packages
  home.packages = with pkgs; [
    gh
    direnv
    nix-direnv
    fzf
    discord
    ghostty
    waybar
    swww
    vicinae
    google-chrome
    stow
    yazi
    rustup
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
