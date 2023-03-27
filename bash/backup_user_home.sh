#!/usr/bin/env bash

# Flags
show_hidden_files=false
force=false

dest_path=
command="ls"

# Parse arguments
while [ "$#" -gt 0 ]; do
  case "${1^^}" in
    "-D" | "--DEST")
      dest_path=$2

      shift
      shift
    ;;
    "-F" | "--FORCE")
      force=true

      shift
    ;;
    "-A" | "--ALL")
      show_hidden_files=true

      shift
    ;;
    *)
      shift
    ;;
  esac
done

if [ -z $dest_path ]; then
  echo "[LOG][ERROR]: You should specify '-d' or '--dest' option."
  exit 1
fi

if [ ! -d $dest_path ]; then
  echo "[LOG][ERROR]: Path '$dest_path' doesn't exit. use '-f' or '--force' flag to create destination path."
  exit 1
fi

if $show_hidden_files; then
  command="$command -aA"
fi

command="$command $HOME"

# Remove extra files
for file in $($command); do
  path="$HOME/$file/node_modules"

  if [ -d $path ]; then
    # TODO: Uncomment following line
    # rm -rf $path
    echo "[LOG][INFO]: Path '$path' removed."
  fi
done

echo "========================="
echo "[LOG][DEBUG]: $dest_path"
