 
#aliases

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
alias aliases='nanosu ~/.bash_aliases'
alias bfunc='nanosu ~/.bash_functions'
alias bprofile='nanosu ~/.profile'
alias history='nanosu ~/.bash_history'
alias conkyrc='nanosu ~/.conkyrc'
alias sources='nanosu /etc/apt//sources.list'
alias rpi-sources='nanosu /etc/apt/sources.list.d/raspi.list'
alias alacyml='nanosu ~/.config/alacritty/alacritty.yml'
alias nanorc='nanosu /etc/nanorc'

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

#utility aliases
alias count='find . -type f | wc -l'
alias cpv='rsync -ah --info=progress2'
alias trash='sudo mv --force -t ~/.local/share/Trash ' # move files to trash instead of delete
alias sudo='sudo'
alias su='sudo su'
alias root='sudo -i'
alias c='clear'
alias mkdir='mkdir -pv'
alias diff='colordiff'
alias h='history'
alias j='jobs -l'
alias ports='netstat -tulanp'
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'
alias wget='wget -c'
alias df='df -H'
alias du='du -ch'
alias usage='du -ch 2> /dev/null |tail -1'
alias totalusage='df -hl --total | grep total'
alias partusage='df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs'
alias most='du -hsx * | sort -rh | head -10'
alias ps2='ps -ef | grep -v $$ | grep -i'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias rm='rm -i'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias flush='sync'
alias hg='history | grep'
alias machine="echo you are logged in to ... `uname -a | cut -f2 -d' '`"
alias info='clear;machine;pwd'
alias kc='killall conky'
alias s='less'        # use less a lot to see config files and logfiles
alias lst='ls -ltr'   # most recently updated files last
alias untar='tar -xvf'
alias brokenlinks='find . -xtype l -printf "%p -> %ln"'
alias path='echo $PATH'
alias netcheck='nmap -sP $(ip -o addr show | grep inet  | grep eth | cut -d  -f 7)'
alias rld='source ~/.bashrc'
alias hogs='ps uxga | sort --key=3.1 -n'
alias visu='EDITOR=nano sudo visudo'
alias c-me='sudo chown -R $USER'
alias me2g='sudo adduser $USER'     #type group name after
alias addgrp='sudo groupadd'        #type group name after
alias md='mkdir'
alias wget2='aria2c -s 2' # download with 2 connections
alias extip='curl icanhazip.com'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias cleardown='cd ~/Downloads && rm -r *'
alias dmesg='dmesg -T'
alias psa="ps auxf"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'
alias bm='bashmount'

#ping output
# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
