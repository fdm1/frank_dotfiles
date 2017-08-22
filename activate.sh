#!/bin/bash

set -e

dotfiles_dir=$(cd "$(dirname "$0")"; pwd)

dotfiles=(psqlrc tmux.conf vimrc.bundles.local vimrc_local vimrc_local_functions)

for name in $dotfiles; do
  rm -rf "${HOME}/.${name}"
  ln -s "${dotfiles_dir}/${name}" "${HOME}/.${name}"
done

vim +PlugInstall +PlugClean! +GoInstallBinaries +qall
