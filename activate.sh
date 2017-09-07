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

get_vim_8() {
  sudo apt-get install -y \
    software-properties-common \
    python-software-properties

  sudo add-apt-repository -y ppa:jonathonf/vim
  sudo apt-get update
  sudo apt-get install -y vim
}

needs_dependencies() {
  needs_deps=false
  packages=(tmux wget curl)
  for package in ${packages[@]}; do
    if [ ! $(which ${package}) ]; then
      needs_deps=true
    else
      echo "${package} exists"
    fi
  done

  if [ $(which vim) ]; then
    VIMVERSION=$(vim --version | head -1 | cut -d ' ' -f 5)
    if [[ ${VIMVERSION} < 8 ]]; then 
      needs_deps=true
    else
      echo "VIM 8+ present"
    fi
  else
    needs_deps=true
  fi
  echo ${needs_deps}
}

get_dependencies() {
  sudo apt-get update
  packages=(tmux wget curl)

  for package in ${packages[@]}; do
    if [ ! $(which ${package}) ]; then
      sudo apt-get install -y ${package}
    fi
  done

  if [ $(which vim) ]; then
    VIMVERSION=$(vim --version | head -1 | cut -d ' ' -f 5)
    if [[ ${VIMVERSION} < 8 ]]; then 
      get_vim_8
    fi
  else
    get_vim_8
  fi
}

tmux_file() {
  if [[ $(tmux -V | awk -F ' ' '{print $NF}') < 2 ]]; then
    echo tmux_lt_2.conf
  else
    echo tmux_gte_2.conf
  fi
}

link_files() {
  dotfiles_dir=$(cd "$(dirname "$0")"; pwd)/dotfiles
  dotfiles=$(ls -1 ${dotfiles_dir} | grep -v tmux)
  dotfiles=$(echo "${dotfiles} $(tmux_file)")

  for name in ${dotfiles[@]}; do

    if [[ ${name} == tmux* ]]; then
      home_name="${HOME}/.tmux.conf"
    else
      home_name="${HOME}/.${name}"
    fi

    echo "  - ${dotfiles_dir}/${name} => ${home_name}"
    rm -rf "${home_name}"
    ln -s "${dotfiles_dir}/${name}" "${home_name}"
  done
}

if [[ $(echo $(needs_dependencies)) == "true" ]]; then
  cmd_step "installing dependencies" get_dependencies
else
  echo "all dependencies exist"
fi

cmd_step "linking_dotfiles" link_files

# Clone base dotfiles from braintree
if [ ! -d vim_dotfiles ]; then
  cmd_step "cloning braintreeps/vim_dotfiles" git clone https://github.com/braintreeps/vim_dotfiles
fi

cmd_step "updating braintreeps/vim_dotfiles" cd vim_dotfiles && git pull origin master
cmd_step "activating all the things" bash activate.sh

if [[ $(ps aux | grep tmux | grep -v grep) ]]; then
  cmd_step "reloading tmux.conf"
  tmux source ${HOME}/.tmux.conf > /dev/null 2>&1
fi

echo "Success!"
