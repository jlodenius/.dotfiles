export PATH=$PATH:$HOME/bin:/Users/jacoblodenius/Library/Python/3.9/bin:/usr/bin
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/Users/jacoblodenius/.local/share/bob/nvim-bin/nvim:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_profile

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
