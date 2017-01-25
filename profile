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
alias ls='ls -Gp' # ls="ls -Fh"
alias c='clear'
alias cal='cal -m'

# if on OpenBSD .. (notetoself: wouldn't a condition on (uname -s) = OpenBSD be applicable here?
#wsconsctl keyboard.encoding=sv.metaesc
#export PKG_PATH=http://ftp.eu.openbsd.org/pub/OpenBSD/$(uname -r)/packages/$(uname -p)/
# end if
