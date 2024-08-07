# New .zshrc config to be used with Tmux, oh-my-posh and zinit

export GCM_CREDENTIAL_STORE=gpg
export GPG_TTY=$(tty)

# Set $PATH variables
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

# Install oh-my-posh if not already installed
OMP_CONFIG="$HOME/.config/oh-my-posh"
OMP_HOME="$HOME/.local/bin/oh-my-posh"

if ! command -v oh-my-posh &> /dev/null; then # Check if Oh My Posh is installed; if it's not,
   mkdir -p "$(dirname $OMP_CONFIG)" # Make the configuration directory
   if [ ! -d ~/.local/bin ]; then # Check if ~/.local/bin exists
       mkdir -p ~/.local/bin # Make it if not
   fi
   curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $HOME/.local/bin # Install Oh My Posh
fi

eval "$(oh-my-posh init --config $OMP_CONFIG/oh-my-posh.yaml zsh)"

# Check for oh-my-posh update
echo "Checking for Oh My Posh update..."
oh-my-posh upgrade

# Initialise Zinit and install if not already there
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Zinit Plugins
zinit light zsh-users/zsh-syntax-highlighting # Highlights syntax
zinit light zsh-users/zsh-completions # Allows for tab-completion of many common commands
zinit light zsh-users/zsh-autosuggestions # Fish-like autosuggestion based on command history

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

# Stole these history settings from https://superuser.com/a/585004
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bindkeys

# PgUp/PgDown for smart history searching
bindkey '^[[5~' up-line-or-beginning-search # Page Up
bindkey '^[[6~' down-line-or-beginning-search # Page Down

# Stole these from https://superuser.com/a/1822652
bindkey '^[[H' beginning-of-line # Home
bindkey '^[[F' end-of-line # End
bindkey  "^[[3~"  delete-char # Del
bindkey ";5D" backward-word # Ctrl + Left
bindkey ";5C" forward-word # Ctrl + Right

# Custom aliases
alias gcm="git-credential-manager"
alias c="clear"
