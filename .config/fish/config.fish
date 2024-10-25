if status is-interactive
  status --is-interactive; and pyenv init --path | source
  status --is-interactive; and direnv hook fish | source
end

# Path exports
set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH $HOME/.local/share/bob/nvim-bin
set -x PATH $PATH $HOME/.local/bin
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CURRENT_DESKTOP Sway
set -x EDITOR vim

# Aliases
alias df="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias kc="kubectl"
alias vim="nvim"
alias bt="bluetuith"

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

# Yank to clipboard (doesn't work as intended, fix at some point..)
set -g fish_clipboard_copy_cmd wl-copy
set -g fish_clipboard_paste_cmd wl-paste

zoxide init fish | source

# <C-T> = Fuzzy find files
# <C-?> = Fuzzy find prev commands ?? TODO: fix this
if type -q fzf
  source /usr/share/fish/vendor_functions.d/fzf_key_bindings.fish
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  set -gx FZF_CTRL_E_COMMAND 'fd --type d --hidden --follow --exclude .git'
end
