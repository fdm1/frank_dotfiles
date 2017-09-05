#!/bin/bash

set -e

cmd_step() {
  echo "=============================================="
  echo $1
  shift
  $@
  echo "=============================================="
  echo
}



link_files() {
  dotfiles_dir=$(cd "$(dirname "$0")"; pwd)
  dotfiles=(psqlrc tmux.conf vimrc.bundles.local vimrc_local vimrc_local_functions)
  for name in ${dotfiles[@]}; do
    echo "  - ${name}"
    rm -rf "${HOME}/.${name}"
    ln -s "${dotfiles_dir}/${name}" "${HOME}/.${name}"
  done
}

cmd_step "linking_dotfiles" link_files

# Clone base dotfiles from braintree
if [ ! -d vim_dotfiles ]; then
  cmd_step "cloning braintreeps/vim_dotfiles" git clone https://github.com/braintreeps/vim_dotfiles
fi

# activate everything
cmd_step "updating braintreeps/vim_dotfiles" cd vim_dotfiles && git pull origin master

cmd_step "activating all the things" bash activate.sh && cd ..

echo "Success!"
