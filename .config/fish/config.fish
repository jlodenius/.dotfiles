if status is-interactive
  status --is-interactive; and pyenv init --path | source
  status --is-interactive; and direnv hook fish | source
end

# Source color scheme from pywal
# source ~/.cache/wal/colors.fish

# Nvidia drivers stuff
set -x LIBVA_DRIVER_NAME nvidia
set -x XDG_SESSION_TYPE wayland
set -x GBM_BACKEND nvidia-drm
set -x __GLX_VENDOR_LIBRARY_NAME nvidia
set -x WLR_NO_HARDWARE_CURSORS 1
set -x MOZ_ENABLE_WAYLAND 1

# Path exports
set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH $HOME/.local/share/bob/nvim-bin
set -x PATH $PATH $HOME/.local/bin

# XDG
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CURRENT_DESKTOP Sway
set -x XDG_RUNTIME_DIR /run/user/(id -u)

# QT
set -Ux QT_QPA_PLATFORMTHEME qt6ct

# Dark mode
set -Ux GTK_THEME Adwaita-dark

# Editor
set -x EDITOR vim

# Aliases
alias kc="kubectl"
alias vim="nvim"
alias bt="bluetuith"
alias lsa="ls -a"

# Pyenv setup
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH

# Install and use NVM via fisher
set -x NVM_DIR $HOME/.nvm

# Fix for GPG sign git commits
set -x GPG_TTY (tty)

# Input method modules
set -x GTK_IM_MODULE fcitx
set -x QT_IM_MODULE fcitx
set -x XMODIFIERS @im=fcitx

# Ollama model dir
set -x OLLAMA_MODELS $HOME/Development/Ollama

# Zoxide
zoxide init fish | source

# Vim keys
fish_vi_key_bindings

# <C-T> = Fuzzy find files
# <C-R> = Fuzzy find recent commands
if type -q fzf
  source /usr/share/fish/vendor_functions.d/fzf_key_bindings.fish
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
end
