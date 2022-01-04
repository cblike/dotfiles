## venv utilities

# Activate a the python virtual environment specified.
# If none specified, use 'venv'.
function vrun() {
  local name="${1:-venv}"
  local venvpath="${name:P}"

  if [[ ! -d "$venvpath" ]]; then
    echo >&2 "Error: no such venv in current directory: $name"
    return 1
  fi

  if [[ ! -f "${venvpath}/bin/activate" ]]; then
    echo >&2 "Error: '${name}' is not a proper virtual environment"
    return 1
  fi

  . "${venvpath}/bin/activate" || return $?
  echo "Activated virtual environment ${name}"
}

# Create a new virtual environment, with default name 'venv'.
function mkv() {
  local name="${1:-venv}"
  local venvpath="${name:P}"

  python3 -m venv "${name}" || return
  echo >&2 "Created venv in '${venvpath}'"
  vrun "${name}"
}
