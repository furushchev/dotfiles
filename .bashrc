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
if shopt | grep histappend 1>/dev/null; then
  shopt -s histappend
fi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTTIMEFORMAT="%Y/%m/%d &H:%M:%S:   "
HISTSIZE=10000000
HISTFILESIZE=20000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
if shopt | grep checkwinsize 1>/dev/null; then
  shopt -s checkwinsize
fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
if shopt | grep globstar 1>/dev/null; then
  shopt -s globstar
fi

# If set, minor errors in the spelling of a directory component in a cd command
# will be corrected. The errors checked for are transposed characters, a missing
# character, and a character too many. If a correction is found, the corrected path
# is printed, and the command proceeds. This option is only used by interactive shells.
if shopt | grep cdspell 1>/dev/null; then
  shopt -s cdspell
fi

# If set, Bash attempts spelling correction on directory names during word
# completion if the directory name initially supplied does not exist.
if shopt | grep dirspell 1>/dev/null; then
  shopt -s dirspell
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
if [ "$(lsb_release -cs)" = "xenial" ]; then
  export TERM=xterm-color
fi
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
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(__git_ps1 [%s])\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w $(__git_ps1 [%s])\$ '
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
alias l='ls -alhF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias open='xdg-open'

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

[ -f ~/.hub/etc/hub.bash_completion ] && . ~/.hub/etc/hub.bash_completion
[ -d ~/.hub/bin ] && export PATH=~/.hub/bin:$PATH
[ -n "`which hub`" ] && $(hub alias -s)
[ -d /usr/local/idea/bin ] && export PATH=/usr/local/idea/bin:$PATH

# conda
if [ -d /usr/local/miniconda3 ]; then
  function conda_enable(){
    export MINICONDA_PATH=/usr/local/miniconda3
    export PATH=$MINICONDA_PATH/bin:$PATH
    export LD_LIBRARY_PATH=$MINICONDA_PATH/lib:$LD_LIBRARY_PATH
    source $MINICONDA_PATH/etc/profile.d/conda.sh
    conda deactivate
  }
fi

# cuda
if [ -d /usr/local/cuda ]; then
  export CUDA_PATH=/usr/local/cuda
  export PATH=$CUDA_PATH/bin:$PATH
  export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH
fi

# openmpi
if [ -d /usr/local/openmpi ]; then
  export OPENMPI_PATH=/usr/local/openmpi
  export PATH=$OPENMPI_PATH/bin:$PATH
  export LD_LIBRARY_PATH=$OPENMPI_PATH/lib:$LD_LIBRARY_PATH
fi

# ROS
export ROSCONSOLE_FORMAT='[${severity}] [${time}] [${node}:${logger}]: ${message}'
[ -e ~/ros/kinetic/devel/setup.bash ] && source ~/ros/kinetic/devel/setup.bash

pr1012(){
    export ROBOT=pr2
    export ROS_ENV_LOADER=/home/furushchev/ros/indigo/devel/env.sh
    rossetmaster 133.11.216.201
    rossetip
}
pr1040(){
    export ROBOT=pr2
    export ROS_ENV_LOADER=/home/furushchev/ros/hydro/devel/env.sh
    rossetmaster 133.11.216.211
    rossetip
}

## Here is the end of automatic initialization

# added by travis gem
[ -f /home/furushchev/.travis/travis.sh ] && source /home/furushchev/.travis/travis.sh
