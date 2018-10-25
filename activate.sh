#!/bin/bash

set -eu -o pipefail

ROOT_DIR=$(cd "$(dirname "$0")"; pwd)

ALL_DOTFILES_DIR=${ROOT_DIR}/dotfiles
LOAD_PERSONAL=0
PERSONAL_DOTFILES_DIR=${ALL_DOTFILES_DIR}/personal
DOTFILES=()
EXCLUDED_PATTERNS=()
INCLUDED_PATTERNS=()

usage() {
  cat <<EOF
Usage: activate.sh \
[--personal] \
[--[no-]tmux] \
[--[no-]vim] \
[--[no-]psql] \
[--[no-]foobar]

Set personalized dotfiles
Arguments
    <[personal]>  Install personal stuff (ohmyzsh, gitconfig)
    <[no-]tmux>   Include or exclude tmux-related dotfiles
    <[no-]vim>    Include or exclude vim-related dotfiles
    <[no-]psql>   Include or exclude psql-related dotfiles
    <[no-]foobar> Include or exclude dotfiles matching string 'foobar'

EOF
  exit 1
}

if [[ $# > 0 ]] && ([[ $1 == "-h" ]] || [[ $1 == "--help" ]]); then usage; fi

tmux_file() {
  if [ $(which tmux) ] && [[ $(tmux -V | awk -F ' ' '{print $NF}') < 2 ]]; then
    echo tmux_lt_2.conf
  else
    echo tmux_gte_2.conf
  fi
}

get_all_dotfiles() {
  ALL_DOTFILES=()
  for filename in $(ls ${ALL_DOTFILES_DIR} | grep -v tmux | grep -v personal); do
    ALL_DOTFILES+="${filename} "
  done
  if [[ ${LOAD_PERSONAL} == 1 ]]; then
    for filename in $(ls ${PERSONAL_DOTFILES_DIR} | grep -v tmux); do
      ALL_DOTFILES+="personal/${filename} "
    done
  fi
  ALL_DOTFILES+="$(tmux_file)"
  echo ${ALL_DOTFILES}
}

# TODO: switch to better options parser
while (( "$#" )); do
  if [[ $1 == "-h" ]] || [[ $1 == "--help" ]] || [[ $(echo $1 | cut -c-2) != "--" ]]; then usage; fi

  if [[ $1 == "--personal" ]]; then
    LOAD_PERSONAL=1
  elif [[ $(echo $1 | cut -c-5) == "--no-" ]]; then
    EXCLUDED_PATTERNS+="$(echo $1 | sed 's/^--no-//') "
  else
    INCLUDED_PATTERNS+="$(echo $1 | sed 's/^--//') "
  fi

  shift
done

if [[ ${#INCLUDED_PATTERNS[@]} > 0 ]]; then
  for pattern in ${INCLUDED_PATTERNS[@]}; do
    if [[ ${pattern} == 'tmux' ]]; then
      DOTFILES+=" $(tmux_file)"
    else
      DOTFILES+=" $(ls ${ALL_DOTFILES_DIR} | grep ${pattern})"
    fi
    if [[ ${LOAD_PERSONAL} == 1 ]]; then
      for filename in $(ls ${PERSONAL_DOTFILES_DIR} | grep ${pattern}); do
        ALL_DOTFILES+="${PERSONAL_DOTFILES_DIR}/${filename} "
      done
    fi
  done
else
  DOTFILES=$(get_all_dotfiles)
fi

if [[ ${#EXCLUDED_PATTERNS[@]} > 0 ]]; then
  for pattern in ${EXCLUDED_PATTERNS[@]}; do
    DOTFILES=$(echo ${DOTFILES} | sed 's/ /\n/g' | grep -v ${pattern})
  done
fi


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

needed_dependencies() {
  packages=""

  TMUX_PACKAGES="tmux "
  VIM_PACKAGES="wget curl "
  if [[ ! -z $(echo ${DOTFILES} | grep tmux) ]]; then packages+=${TMUX_PACKAGES}; fi
  if [[ ! -z $(echo ${DOTFILES} | grep vim) ]]; then
    packages+=${VIM_PACKAGES}

    if [ $(which vim) ]; then
      VIMVERSION=$(vim --version | head -1 | cut -d ' ' -f 5)
      if [[ ${VIMVERSION} < 8 ]]; then
        packages+=" vim8"
      fi
    else
      packages+=" vim8"
    fi
  fi

  if [[ ${LOAD_PERSONAL} == 1 ]]; then
    packages+=" zsh"
  fi

  for package in ${packages[@]}; do
    if [ $(which ${package}) ]; then
      packages=$(echo ${packages} | sed 's/\ /\n/g' | grep -v ${package})
    fi
  done

  echo ${packages}
}

get_dependencies() {
  sudo apt-get update

  packages=$(needed_dependencies)
  for package in ${packages[@]}; do
    if [[ ${package} == 'vim8' ]]; then
      get_vim_8
    else
      sudo apt-get install -y ${package}
    fi
  done
}


link_files() {
  for name in ${DOTFILES[@]}; do

    if [[ ${name} == tmux* ]]; then
      home_name="${HOME}/.tmux.conf"
    else
      home_name="${HOME}/.$(basename ${name})"
    fi

    echo "  - ${ALL_DOTFILES_DIR}/${name} => ${home_name}"
    rm -rf "${home_name}"
    if [ ! -d ${ALL_DOTFILES_DIR}/${name} ]; then
      ln -s "${ALL_DOTFILES_DIR}/${name}" "${home_name}"
    fi
  done
}

link_gnupgp_conf() {
  cd ${ROOT_DIR}
  for filename in $(ls gnupg/*.conf); do
    rm ${HOME}/.gnupg/$(basename ${filename})
    ln -s ${ROOT_DIR}/${filename} ${HOME}/.gnupg/$(basename ${filename})
  done
}


install_ohmyzsh() {
  # https://github.com/robbyrussell/oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  chsh -s $(which zsh)
}

packages=($(needed_dependencies))
if [[ ${#packages[@]} > 0 ]]; then
  cmd_step "installing dependencies (${packages})" get_dependencies
else
  echo "all dependencies exist"
fi

if [[ ${LOAD_PERSONAL} == 1 ]] && [[ ! -d $HOME/.oh-my-zsh ]]; then
  cmd_step "installing ohmyzsh" install_ohmyzsh
fi


INTELLIJ_CODESTYLES_DIR=/Users/fmassi/Library/Preferences/IdeaIC2017.3/codestyles
if [ -d $INTELLIJ_CODESTYLES_DIR ]; then
  if [ ! -d intellij-config ]; then
    cmd_step "cloning braintreeps/intellij-config" git clone https://github.com/braintreeps/intellij-config
  fi

  if [ ! -e  $INTELLIJ_CODESTYLES_DIR/intellij-java-google-style.xml ]; then
    cmd_step "link bt intellij styles" ln -s intellij-config/config/codestyles/intellij-java-google-style.xml $INTELLIJ_CODESTYLES_DIR/intellij-java-google-style.xml
  fi
fi

cmd_step "linking_dotfiles" link_files

# Clone base dotfiles from braintree
if [[ ! -z $(echo ${DOTFILES} | grep vim) ]]; then

  VIM_HOME=$HOME/.vim
  if [ ! -d $VIM_HOME ]; then
    cmd_step "cloning braintreeps/vim_dotfiles into ~/.vim" git clone https://github.com/braintreeps/vim_dotfiles $VIM_HOME
  fi

  cmd_step "updating braintreeps/vim_dotfiles" cd $VIM_HOME && git pull origin master
  cmd_step "activating all the things" bash $VIM_HOME/activate.sh
fi

if [[ $(ps aux | grep tmux | grep -v grep) ]] && [[ ! -z $(echo ${DOTFILES} | grep tmux) ]]; then
  cmd_step "reloading tmux.conf"
  tmux source ${HOME}/.tmux.conf > /dev/null 2>&1
fi

if [[ ${LOAD_PERSONAL} == 1 ]]; then
  cmd_step "linking gnupg conf files" link_gnupgp_conf
fi

echo "Success!"
