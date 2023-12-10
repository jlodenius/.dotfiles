export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/share/bob/v0.9.0/nvim-linux64/bin
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CURRENT_DESKTOP=Sway
export EDITOR='vim'

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

ZSH_THEME="robbyrussell"

plugins=(git)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_profile
source /usr/share/nvm/init-nvm.sh

neofetch
