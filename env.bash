#!/usr/bin/env bash

readonly VERSION="1.0"

_die() { printf '  Error: %s\n' "$*" >&2 && exit 1; }

cmd_env_version() {
  cat >&1 <<-_EOF

  $PROGRAM env $VERSION - a pass extension that creates a string "export name=value" into clipboard
_EOF
}

cmd_env_usage() {
  cmd_env_version
  cat >&1 <<-_EOF

  USAGE:

    $PROGRAM env pass-name

  OPTIONS:

    -V, --version                     Show version information
    -h, --help                        Print this help message and exit

  EXAMPLES:

    pass insert -m pass-name          Store env-variable value in first line and env-variable name as second line
    pass env pass-name                Copy a string "export name=value" into clipboard
_EOF
}

cmd_env() {
  local passfile="${PREFIX}/${1}.gpg"
  if [ -f "$passfile" ]; then
    set -- $($GPG -d "${GPG_OPTS[@]}" "$passfile")
    local name=$2
    local value=$1
    clip "export $name=\"${value}\"" "$name"
  fi
}

small_arg="h:V"
long_arg="help:version"
opts="$($GETOPT -o $small_arg -l $long_arg -n "$PROGRAM $COMMAND" -- "$@")"
err=$?
eval set -- "$opts"
while true; do case $1 in
  -h|--help) shift; cmd_env_usage; exit 0 ;;
  -V|--version) shift; cmd_env_version; exit 0 ;;
  --) shift; break ;;
esac done

if [ $err -ne 0 ]; then
  cmd_env_usage
  exit 1
fi

if [ "$COMMAND" == "env" ]; then
  cmd_env "$@"
fi

exit 0
