#!/bin/bash

set -eu -o pipefail

ROOT_DIR=$(cd "$(dirname "$0")"; pwd)
ALL_DOTFILES_DIR=${ROOT_DIR}/dotfiles
DOTFILES=()


setup_config_dir() {
  if [ ! -d ~/.config/nvim ]; then
    mkdir -p ~/.config/nvim
  fi

  rm ~/.config/nvim/init.vim
  ln -s ${ROOT_DIR}/config/nvim/init.vim ~/.config/nvim/init.vim
}

install_nvim_plug() {
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_neovim() {
  if [[ -z $(which nvim) ]]; then
    sudo apt update
    sudo apt install -y neovim
    setup_config_dir
    install_nvim_plug
  else
    echo "nvim already installed; skipping..."
  fi
}

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

cmd_step "install neovim" install_neovim
cmd_step "setup config dir" setup_config_dir
cmd_step "linking dotfiles" link_files

nvim +PlugInstall +PlugClean! +qall

echo "Success!"