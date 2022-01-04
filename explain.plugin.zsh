# -------------------------------------------------------------------------------------------------
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
# -------------------------------------------------------------------------------------------------

function explain-command(){
  if [[ $# == 0 ]]; then
        cat <<EOH
  Opens http://explainshell.com to explain given command.

  usage: explain <cmd> <args>
  example: explain ps faux
EOH
    return 0
  fi

  local raw=$@
  local cmd=${raw/ /+}
  local url="http://explainshell.com/explain?cmd=$cmd"

  if which xdg-open &> /dev/null; then
    xdg-open $url
  elif which open &> /dev/null; then
    open $url
  else
    echo "xdg-open nor open found. Can not open browser!"
  fi
}

function explain-last-command(){
  local last="`fc -nl -1`"
  explain-command $last
}

alias explain=explain-command
alias explain-last=explain-last-command
