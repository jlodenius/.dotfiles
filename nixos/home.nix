{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/tmux.nix
    ./modules/fish.nix
  ];

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
    gcc
    gnumake
  ];

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
