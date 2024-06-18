# New .zshrc config to be used with Tmux, oh-my-posh and zinit

export GCM_CREDENTIAL_STORE=gpg
export GPG_TTY=$(tty)

# Set $PATH variables
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

# Install oh-my-posh if not already installed
OMP_CONFIG="$HOME/.config/oh-my-posh/oh-my-posh.yaml"
OMP_HOME="$HOME/.local/bin/oh-my-posh"

if [ -z "oh-my-posh -v" ]; then
   mkdir -p $OMP_HOME
   curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $HOME/.local/bin
fi

eval "$(oh-my-posh init --config $OMP_CONFIG zsh)"

# Initialise Zinit and install if not already there
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Zinit Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

autoload -U compinit && compinit

# Set micro as editor and other micro variables
export EDITOR=micro
export MICRO_TRUECOLOR=1

# ZSH history settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ZSH Bindkeys

# Stole these from https://superuser.com/a/1822652
# Home & End Key to skip to start and end of lines
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Del key to delete keys:
bindkey  "^[[3~"  delete-char

# Ctrl+Left/Right to jump words
bindkey ";5D" backward-word
bindkey ";5C" forward-word

# Custom aliases
alias gcm="git-credential-manager"
alias c="clear"
