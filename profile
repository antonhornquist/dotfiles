# Unixy profile / bash stuff

# Simplify console prompt
#export PS1="\h:\W \u\$" # <- OSX Leopard default, not used
export PS1="\W: " # simple

# Preferred Editor
export VISUAL=vim
export EDITOR=vim

# Retain a lot of history
HISTSIZE=10000

# Include Rubygems by default
export RUBYOPT="rubygems"

# Basic Aliases
alias ls='ls -Gp'
# alias ls="ls -Fh"
alias c='clear'
alias cal='cal -m'
alias eprofile='$EDITOR ~/.profile'
alias sprofile='source ~/.profile'
# alias jrake='jruby -S rake'
alias cr="clear; rake"
alias gitsu="git status --untracked=no"

# Development Aliases
# source "${JAH_DEVELOPMENT}/aliases.dev"
