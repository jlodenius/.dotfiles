{
  config,
  pkgs,
  ...
}: {
  home.username = "jacob";
  home.homeDirectory = "/home/jacob";
  home.stateVersion = "25.11";

  # Environment Variables (Session-wide)
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
    MOZ_ENABLE_WAYLAND = "1";

    # App specific
    AWS_PROFILE = "caesari-authentik-saml";
  };

  # Path Exports
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
  ];

  # Fish Shell (The Clean Way)
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

  # Git Configuration
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

  # User Packages (Local apps)
  home.packages = with pkgs; [
    gh
    direnv
    nix-direnv
    fzf
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
