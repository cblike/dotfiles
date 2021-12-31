# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/shell/powerline.sh

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color|*-256color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#set color_prompt force_color_prompt

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

# left prompt
if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
complete -F compgen _update_ps1

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls -ahl --color=auto'
#    alias dir='dir -ahl --color=auto'
#    alias vdir='vdir --color=auto'

#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

shopt -s expand_aliases

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
complete -F _longopt .bash_aliases

if [ -e $HOME/.bash_functions ]; then
    source $HOME/.bash_functions
fi
complete -F _longopt .bash_functions

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

#if the command-not-found package is installed, use it

if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
function command_not_found_handle() {
	        # check because c-n-f could've been removed in the meantime
    if [ -x /usr/lib/command-not-found ]; then
            /usr/lib/command-not-found -- "$1"
             return $?
      elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
             return $?
      else
          printf "%s: command not found\n" "$1" >&2
	     return 127
     fi }
 fi
complete -F _longopt command_not_found_handle

function greetings() {
     echo "Waddup, bitch! Welcome to bash!"
}
complete -F _command greetings

# PATH:
export PATH="/home/cblike/node_modules/.bin:$PATH"
export GOPATH=$HOME/go
export PATH="/usr/local/go/bin:${PATH}"
export PATH="/home/cblike/go/bin:${PATH}"
export PATH="/home/cblike/.google-drive-upload/bin:${PATH}"
export PATH="$HOME/.rustup/toolchains/stable-aarch64-unknown-linux-gnu/bin:${PATH}"
eval "$(thefuck --alias)"
eval "$(pandoc --bash-completion)"

# Sources list
. /usr/local/alacritty/extra/completions/alacritty.bash
. /home/cblike/.complete-alias
. /etc/bash_completion.d/dlocate-completion
. /etc/profile.d/bash_completion.sh
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
. /etc/bash_completion.d/pip
. <(cod init $$ bash)
. /home/cblike/bashman/release/completions/cargo-bashman.bash
. ~/.local/share/bash-completion/completions/cargo
. ~/.local/share/bash-completion/completions/rustup
. ~/.rustup/toolchains/stable-aarch64-unknown-linux-gnu/etc/bash_completion.d/cargo
. "$HOME/.cargo/env"

neofetch

greetings

INCLUDE_YARN_COMPLETION=false

PATH_TO_NPM_COMPLETION="/usr/lib/node_modules/npm-completion"
source $PATH_TO_NPM_COMPLETION/npm-completion.sh
