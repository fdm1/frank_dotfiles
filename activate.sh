#!/bin/bash

set -eu -o pipefail

ROOT_DIR=$(cd "$(dirname "$0")"; pwd)
ALL_DOTFILES_DIR=${ROOT_DIR}/dotfiles
DOTFILES=()

get_all_dotfiles() {
  ALL_DOTFILES=()
  for filename in $(ls ${ALL_DOTFILES_DIR}); do
    ALL_DOTFILES+="${filename} "
  done
  echo ${ALL_DOTFILES}
}

DOTFILES=$(get_all_dotfiles)

cmd_step() {
  echo "=============================================="
  echo $1
  shift
  $@
  echo "=============================================="
  echo
}

link_files() {
  for name in ${DOTFILES[@]}; do

    home_name="${HOME}/.$(basename ${name})"

    echo "  - ${ALL_DOTFILES_DIR}/${name} => ${home_name}"
    rm -rf "${home_name}"
    if [ ! -d ${ALL_DOTFILES_DIR}/${name} ]; then
      ln -s "${ALL_DOTFILES_DIR}/${name}" "${home_name}"
    fi
  done
}

cmd_step "linking_dotfiles" link_files

nvim +PlugInstall +PlugClean! +qall

echo "Success!"
