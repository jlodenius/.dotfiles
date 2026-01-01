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
      cd = "z";
    };
    interactiveShellInit = ''
      fish_vi_key_bindings
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
    };
    extraConfig = {
      init.defaultBranch = "master";
    };
  };

  # User Packages (Local apps)
  home.packages = with pkgs; [
    gh
    direnv
    nix-direnv
    zoxide
    fzf
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
