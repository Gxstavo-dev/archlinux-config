# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
export PATH=$PATH:$(go env GOPATH)/bin

# Turso
export PATH="$PATH:/home/gxstavo/.turso"
export PATH="$HOME/.local/bin:$PATH"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
export PATH="$HOME/.local/bin:$PATH"

stty -ixon

[ -f "/home/gxstavo/.ghcup/env" ] && . "/home/gxstavo/.ghcup/env" # ghcup-env
export PATH="/home/gxstavo/.cache/.bun/bin:$PATH"
