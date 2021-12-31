# Terminal color support
export TERM="xterm-256color"

# Keep paths clear:
typeset -U path
typeset -U gopath
typeset -U fpath

# Zsh Completion setup
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _match _approximate
zstyle ':completion:*' completions set
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob set
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' prompt '%e'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' substitute set

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_functions/.histfile
HISTSIZE=200000
SAVEHIST=200000
setopt autocd extendedglob notify
bindkey -e

# Invoke Command Not Found:
[[ -e /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found

# autoload help and user defined functions
autoload run-help
greetings() {
	echo "'Sup bitch! Welcome to ZSH"
}

# Source files
. ~/.zsh_functions/.zsh_alias
. ~/.zsh_functions/_zshfunc
. ~/.zsh_functions/auto-ls.zsh
. /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. /home/cblike/.rustup/toolchains/stable-aarch64-unknown-linux-gnu/bin
. ~/.zsh_functions/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh

# use zsh and bash completions
autoload -Uz compinit
compinit
autoload -U +X bashcompinit
bashcompinit

# initialize prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.zsh_functions/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh_functions/.p10k.zsh ]] || source ~/.zsh_functions/.p10k.zsh ]]

neofetch

greetings
