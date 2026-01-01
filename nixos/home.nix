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
      # This line defines the order of what you see
      format = "$directory$git_branch$git_status$character";

      git_branch = {
        symbol = " ";
        style = "bold #f2777a";
        format = "on [$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold #99cc99";
        # Simple format that avoids the bracket parsing error
        format = "([$all_status$ahead_behind]($style) )";
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
