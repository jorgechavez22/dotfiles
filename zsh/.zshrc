# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git
  sudo
  command-not-found
  history
  colorize
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ============================================
# User configuration
# ============================================

# Aliases básicos
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CF'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --all'

# ============================================
# PATH
# ============================================

# Agregar Flutter al PATH
export PATH="$HOME/develop/flutter/bin:$PATH"

# ============================================
# Historial
# ============================================

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# ============================================
# Corrección automática de comandos
# ============================================

setopt CORRECT
# setopt CORRECT_ALL

# ============================================
# Variables de entorno
# ============================================

export EDITOR='nvim'
