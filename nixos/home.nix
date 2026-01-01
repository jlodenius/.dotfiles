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

      # Set colors
      set -g fish_color_autosuggestion 747369
      set -g fish_color_command 99cc99
      set -g fish_color_comment ffcc66
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_end cc99cc
      set -g fish_color_error f2777a
      set -g fish_color_escape 66cccc
      set -g fish_color_history_current --bold
      set -g fish_color_match 6699cc
      set -g fish_color_normal normal
      set -g fish_color_operator 6699cc
      set -g fish_color_param d3d0c8
      set -g fish_color_quote ffcc66
      set -g fish_color_redirection d3d0c8
      set -g fish_color_search_match white --background=brblack
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_status red
      set -g fish_color_user brgreen
      set -g fish_color_valid_path --underline

      # Pager colors
      set -g fish_pager_color_description B3A06D
      set -g fish_pager_color_progress brwhite --background=cyan
      set -g fish_pager_color_selected_background --background=brblack

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
