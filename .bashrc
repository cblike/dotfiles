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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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
    #alias ls='exa -ahl --group-directories-first --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

#Alliases
#ls aliases
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias l='exa -a | egrep "^\."'

#grep aliases: (good for log/journals)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'

#config aliases
alias nanosu='sudo nano -l'
alias bashrc='nanosu ~/.bashrc'

#apt aliases
alias updt='sudo apt update'
alias get-updt='sudo apt-get update'
alias upgrd='sudo apt upgrade'
alias full-upgrd='sudo apt full-upgrade'
alias rpi-updt='sudo rpi-update'
alias srch='sudo apt search'
alias inst='sudo apt install'
alias rmv='sudo apt remove'
alias prg='sudo apt purge'
alias autormv='sudo apt autoremove'
alias autocln='sudo apt clean'
alias cln='sudo apt clean'
alias dpki='sudo dpkg -i'
alias dpkr='sudo dpkg -r'
#alias mirror='sudo mv /etc/apt/sources.list /etc/apt/#sources.list.bak && sudo netselect-apt'

#directory navigation:
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

##FUNCTIONS

function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -F --color=auto
}

complete -F _command cl

function up() {

        COUNTER=$1
        while [[ $COUNTER -gt 0 ]]
         do
          UP="${UP}../"
          COUNTER=$(( $COUNTER -1 ))
         done
        echo "cd $UP"
        cd $UP
        UP=''
}

complete -F _command up

# grep command history.  Uses function so a bare 'gh' doesn't just hang waiting for input.
function gh() {
  if [ -z "$1" ]; then
    echo "Bad usage. try:gh run_test";
  else
    history | egrep $* |grep -v "gh $*"
  fi
}

complete -F _command gh

# cd to the directory a symbolically linked file is in.
function cdl() {
    if [ "x$1" = "x" ] ; then
        echo "Missing Arg"
    elif [ -L "$1" ] ; then
        link=`/bin/ls -l $1 | tr -s ' ' | cut -d' ' -f10`
        if [ "x$link" = "x" ] ; then
            echo "Failed to get link"
            return
        fi
        dirName_=`dirname $link`
        cd "$dirName_"
    else
        echo "$1 is not a symbolic link"
    fi
    return
}

complete -F _command cdl

# cd to the dir that a file is found in.
function cdff() {
    filename=`find . -name $1 | grep -iv "Permission Denied" | head -1`
    if [ "xx${filename}xx" != "xxxx" ] ; then
        dirname=${filename%/*}
        if [ -d $dirname ] ; then
            cd $dirname
        fi
    fi
}

complete -F _command cdff

function extract() {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
   fi
}

complete -F _command extract

#function to kill processes by name
function kp() {
  ps aux | grep $1 > /dev/null
  mypid=$(pidof $1)
  if [ "$mypid" != "" ]; then
    kill -9 $(pidof $1)
    if [[ "$?" == "0" ]]; then
      echo "PID $mypid ($1) killed."
    fi
  else
    echo "None killed."
  fi
  return;
}

complete -F _command kp

# cp with progress bar
function cp_p() {
  if [ `echo "$2" | grep ".*\/$"` ]; then
    pv "$1" > "$2""$1"
  else
    pv "$1" > "$2"/"$1"
  fi
}

complete -F _command cp_p

# clock - A bash clock that can run in your terminal window.
function clock() {
while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
}

complete -F _command clock

function dirsize() {
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}

complete -F _command dirsize

function showpkg() {
  apt-cache pkgnames | grep -i "$1" | sort | tee /home/pi/package_list.txt
  return;
}

complete -F _command showpkg

# Runs Nano as super user with these options:
#   * enable experimental undo (will most probably crash
#       if going deeper than first undo level!!!!!!!!!
#   * autoindent,
#   * constantly show the cursor position,
#   * log search and replace strings,
#   * enable edit of multiple files,
#   * treat punctuation as part of words,
#   * smooth scrolling and
#   * tab size set to 4 spaces.
function nanoSU() {
  sudo nano "${_NANO_OPTIONS[@]}" "$@"
}

complete -F _command nanoSU

# Runs command in background. It doesn't hang up if shell
# is closed and it doesn't print output.
function runCmdInBgrnd() {
  nohup "$@" &>/dev/null &
}

complete -F _command runCmdInBgrnd

# Changes the hue of default blue color in Linux terminal (tty),
# that is otherwise hard to read.
function chngBlueInTerm() {
  echo -en "\e]PC7373C9"
}

complete -F _command chngBlueInTerm

# Prints PATH variable, each entry in its own line.
function listPath() {
  echo -e ${PATH//:/\\n}
}

complete _f _command listPath

# Trims SSD disk.
function trim() {
  sudo fstrim -v /
}

complete -F _command trim

# Prints packages that were installed by the user
function printUsrPkg() {
  cat /var/log/apt/history.log \
    | grep "apt install" \
    | sed "s/.* //" \
    | sudo tee /home/pi/user_installed_packages.txt
}

complete -F _command printUsrPkg

# Prints all installed packages.
function printAllPkg() {
  dpkg --get-selections \
    | grep -v deinstall \
    | sudo tee /home/pi/all_installed_packages.txt
}

complete -F _command printAllPkg

# Converts man section number into a description.
function getManSection() {
  case "$1" in
    1)      echo "user command"                     ;;
    2)      echo "system call"                      ;;
    3)      echo "c function"                       ;;
    4)      echo "device file"                      ;;
    5)      echo "file format or convention"        ;;
    6)      echo "game"                             ;; 
    7)      echo "miscallaneous"                    ;;
    8)      echo "su command"                       ;;
    9)      echo "kernel routine"                   ;;
  esac
}

complete  -F _command getManSection

function comp_cd()
{
	local IFS=$' \t\n'	# normalize IFS
	local cur _skipdot _cdpath
	local i j k

	# Tilde expansion, with side effect of expanding tilde to full pathname
	case "$2" in
	\~*)	eval cur="$2" ;;
	*)	cur=$2 ;;
	esac

	# no cdpath or absolute pathname -- straight directory completion
	if [[ -z "${CDPATH:-}" ]] || [[ "$cur" == @(./*|../*|/*) ]]; then
		# compgen prints paths one per line; could also use while loop
		IFS=$'\n'
		COMPREPLY=( $(compgen -d -- "$cur") )
		IFS=$' \t\n'
	# CDPATH+directories in the current directory if not in CDPATH
	else
		IFS=$'\n'
		_skipdot=false
		# preprocess CDPATH to convert null directory names to .
		_cdpath=${CDPATH/#:/.:}
		_cdpath=${_cdpath//::/:.:}
		_cdpath=${_cdpath/%:/:.}
		for i in ${_cdpath//:/$'\n'}; do
			if [[ $i -ef . ]]; then _skipdot=true; fi
			k="${#COMPREPLY[@]}"
			for j in $( compgen -d -- "$i/$cur" ); do
				COMPREPLY[k++]=${j#$i/}		# cut off directory
			done
		done
		$_skipdot || COMPREPLY+=( $(compgen -d -- "$cur") )
		IFS=$' \t\n'
	fi

	# variable names if appropriate shell option set and no completions
	if shopt -q cdable_vars && [[ ${#COMPREPLY[@]} -eq 0 ]]; then
		COMPREPLY=( $(compgen -v -- "$cur") )
	fi

	# append slash to passed directory name that is the only completion.
	# readline will not do this if we complete from CDPATH
	if [[ ${#COMPREPLY[@]} -eq 1 ]]; then
		i=${COMPREPLY[0]}	# shorthand
		if [[ "$cur" == "$i" ]] && [[ "$i" != "*/" ]]; then
			COMPREPLY[0]+=/
		fi
	fi
	return 0
}

complete -o filenames -o nospace -o bashdefault -F _comp_cd cd

function inpath()
{
	local PROG
	path=$(echo $PATH | sed 's/^:/.:/
				s/::/:.:/g
				s/:$/:./
				s/:/ /g')

	for x in $path
	do
		[ -x $x/$1 ] && { PROG=$x/$1; break; }
	done
	[ -n "$PROG" ]
}

complete -F _longopt inpath

function func()
{
	local status=0

	if [ $# -eq 0 ] ; then
		echo "usage: func name [name...]" 1>&2
		return 1
	fi

	for f
	do
		if [ "$(builtin type -type $f)" != "function" ] ; then
			echo "func: $f: not a function" 1>&2
			status=1	# one failed
			continue
		fi
		builtin type $f | sed 1d
	done
	return $status
}

complete -F _longopt func

neofetch | lolcat