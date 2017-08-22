#!/bin/bash

set -e

# link my files
dotfiles_dir=$(cd "$(dirname "$0")"; pwd)
dotfiles=(psqlrc tmux.conf vimrc.bundles.local vimrc_local vimrc_local_functions)
for name in $dotfiles; do
  rm -rf "${HOME}/.${name}"
  ln -s "${dotfiles_dir}/${name}" "${HOME}/.${name}"
done

# Clone base dotfiles from braintree
if [ ! -d vim_dotfiles ]; then
  git clone https://github.com/braintreeps/vim_dotfiles
fi

# activate everything
cd vim_dotfiles
git pull origin master
bash activate.sh
cd ..
