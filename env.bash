#!/usr/bin/env bash

readonly VERSION="1.0"

die() { printf '  Error: %s\n' "$*" >&2 && exit 1; }

cmd_env_version() {
  cat <<-_EOF

  $PROGRAM env $VERSION - a pass extension that creates a string "export name=value" into clipboard
_EOF
}

cmd_env_usage() {
  cmd_env_version
  cat <<-_EOF

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
    local value name line
    {
      read -r value
      read -r name
      while IFS= read -r line; do
        if [ -n "$line" ]; then
          printf '%s\n' "$line"
        fi
      done
    } < <($GPG -d "${GPG_OPTS[@]}" "$passfile")
    if [ -z "$name" ]; then
      die "Password entry '$1' is missing the variable name on the second line."
    fi
    clip "export $name=\"${value}\"" "$name"
  fi
}

small_arg="hV"
long_arg="help,version"
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
  # Check if a pass-name argument was provided
  if [ "$#" -eq 0 ]; then
    cmd_env_usage
    exit 1
  else
    cmd_env "$@"
  fi
fi

exit 0
