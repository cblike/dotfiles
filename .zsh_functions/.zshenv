export PATH="/home/cblike/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/games:/home/cblike/node_modules/.bin:/usr/local/go/bin:/home/cblike/go/bin:$PATH"

export PATH="$HOME/.rustup/toolchains/stable-aarch64-unknown-linux-gnu/bin:${PATH}"

# added for npm-completion https://github.com/Jephuff/npm-bash-completion
PATH_TO_NPM_COMPLETION="/usr/bin/../lib/node_modules/npm-completion"
source $PATH_TO_NPM_COMPLETION/npm-completion.sh
PATH_TO_NPM_COMPLETION="/lib/node_modules/npm-completion"
PATH_TO_NPM_COMPLETION="/usr/lib/node_modules/npm-completion"

. "$HOME/.cargo/env"

# add go bin to gopath:
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

# add zsh_functions and cpan to fpath:
fpath=('~/.zsh_functions/completions'$fpath)
fpath=('~/.zsh_functions/zshfunc'$fpath)
fpath=('/home/cblike/.cpan/build/App-AppSpec-0.006-0/share/completion/zsh' $fpath)

