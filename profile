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

# Basics
# set -o vi

# Colorize CLI
# export CLICOLOR=1

# Basic Aliases
alias ls='ls -Gp'
# alias ls="ls -Fh"
alias c='clear'
alias cal='cal -m'
alias eprofile='$EDITOR ~/.profile'
alias sprofile='source ~/.profile'
# alias jrake='jruby -S rake'

# Documents
export JAH_DOCUMENTS="${HOME}/Documents"

# Dropbox
export JAH_DROPBOX="${HOME}/Dropbox"

# Notes
export JAH_NOTES="${JAH_DROPBOX}/Notes"

# Development
export JAH_DEVELOPMENT="${JAH_DOCUMENTS}/Development"
export JAH_RB_DEV_DIR="${JAH_DEVELOPMENT}/Ruby"
export JAH_SC_DEV_DIR="${JAH_DEVELOPMENT}/SuperCollider"
export JAH_META_DEV_DIR="${JAH_DEVELOPMENT}/meta"
export JAH_HS_DEV_DIR="${JAH_DEVELOPMENT}/Other/Haskell"
export JAH_JAVA_DEV_DIR="${JAH_DEVELOPMENT}/Other/Java"
export JAH_C_DEV_DIR="${JAH_DEVELOPMENT}/Other/C"

# Helper Scripts
# export JAH_HELPERS_DIR="${JAH_DEVELOPMENT}/Other/Helpers"
# export PATH=$PATH:$JAH_HELPERS_DIR
# alias f="source fave-dirs.sh"
# alias r="edit-file-by-extension.sh rb"
# alias s="edit-file-by-extension.sh sc"
# alias h="edit-file-by-extension.sh hs"
# alias j="edit-file-by-extension.sh java"
# alias c="edit-file-by-extension.sh c"

# Ruby
export PATH=$PATH:$JAH_RB_DEV_DIR/Other/jruby-1.6.7/bin
alias cr="clear; rake"
export JRUBY_HOME=/Users/antonhornquist/Documents/Development/Ruby/Other/jruby-1.5.1

# meta-rb
export JAH_META_RB_DEV_DIR="${JAH_RB_DEV_DIR}/meta-rb"
export RUBYOPT="${RUBYOPT} -I${JAH_META_RB_DEV_DIR}"
export JAH_RSCLASS_RB_DEV_DIR="${JAH_RB_DEV_DIR}/rsclass-rb"
export RUBYOPT="${RUBYOPT} -I${JAH_RSCLASS_RB_DEV_DIR}"

# Grrr
export JAH_GRRR_RB_DEV_DIR="${JAH_RB_DEV_DIR}/grrr-rb"
export JAH_GRRR_SC_DEV_DIR="${JAH_SC_DEV_DIR}/grrr-sc"
export JAH_GRRR_META_DEV_DIR="${JAH_META_DEV_DIR}/grrr-meta"
export RUBYOPT="${RUBYOPT} -I${JAH_GRRR_RB_DEV_DIR}"

# scext-rb
export JAH_SCEXT_RB_DEV_DIR="${JAH_RB_DEV_DIR}/scext-rb"
export RUBYOPT="${RUBYOPT} -I${JAH_SCEXT_RB_DEV_DIR}"

# Development Aliases
# source "${JAH_DEVELOPMENT}/aliases.dev"

# Git
alias gitsu="git status --untracked=no"

# Mysql
export PATH=$PATH:/usr/local/mysql/bin

# Fave-dirs
export FAVE_DIRS=$JAH_RB_DEV_DIR/a-rb:$JAH_GRRR_SC_DEV_DIR:$JAH_GRRR_RB_DEV_DIR/lib:$JAH_GRRR_RB_DEV_DIR/test:$JAH_GRRR_META_DEV_DIR:$JAH_SCEXT_RB_DEV_DIR/lib:$JAH_SCEXT_RB_DEV_DIR/test:$JAH_META_RB_DEV_DIR

# Friend Stuff
export FRIEND_CURRENT_REV="rev120"
export FRIEND_ROOT="${JAH_SC_DEV_DIR}/jah/${FRIEND_CURRENT_REV}/Friend"
export FRIEND_VIM_COMMAND="mvim"
export PATH=$PATH:$FRIEND_ROOT/Helpers # add ? to path
alias friend="cd '$FRIEND_ROOT'"
alias ftodo="mvim '$FRIEND_ROOT/TODO'"

##
# Your previous /Users/antonhornquist/.profile file was backed up as /Users/antonhornquist/.profile.macports-saved_2009-03-31_at_21:21:54
##

# MacPorts Installer addition on 2009-03-31_at_21:21:54: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2009-03-31_at_21:21:54: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.


