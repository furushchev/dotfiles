## ~/.bashrc

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTTIMEFORMAT="%Y/%m/%d &H:%M:%S:   "
HISTSIZE=10000000
HISTFILESIZE=20000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# If set, minor errors in the spelling of a directory component in a cd command
# will be corrected. The errors checked for are transposed characters, a missing
# character, and a character too many. If a correction is found, the corrected path
# is printed, and the command proceeds. This option is only used by interactive shells.
shopt -s cdspell

# If set, Bash attempts spelling correction on directory names during word
# completion if the directory name initially supplied does not exist.
shopt -s dirspell

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
  xterm-256color) color_prompt=yes;;
esac

# git prompt
__git_ps1() { :; }
  GIT_PS1_SHOWDIRTYSTATE=true
if [ "$(uname)" = "Darwin" ]; then
  if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
  fi
  if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ($(__git_ps1 [%s]))'
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ($(__git_ps1 [%s]))'
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if [ -n "$(which colordiff)" ]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# load hub command if exists
if [ ! -d "$HOME/.hub" ]; then
  hub_version=2.2.9
  _system_type=$(uname)
  hub_dirname="hub-${_system_type,,}-amd64-${hub_version}"
  hub_uri="https://github.com/github/hub/releases/download/v${hub_version}/${hub_dirname}.tgz"
  curl -L -o /tmp/hub.tgz $hub_uri -C /tmp
  mv -f /tmp/${hub_dirname} ~/.hub
fi
[ -f ~/.hub/etc/hub.bash_completion ] && . ~/.hub/etc/hub.bash_completion
[ -n "`which hub`" ] && $(hub alias -s)

## Here is the end of automatic initialization
