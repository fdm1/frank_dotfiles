#!/bin/bash

set -eu -o pipefail

DOTFILES_DIR=$(cd "$(dirname "$0")"; pwd)/dotfiles
DOTFILES=()
EXCLUDED_PATTERNS=()
INCLUDED_PATTERNS=()

usage() {
  cat <<EOF
Usage: activate.sh \
[--[no-]tmux] \
[--[no-]vim] \
[--[no-]psql] \
[--[no-]foobar]

Set personalized dotfiles
Arguments
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
	for filename in $(ls --ignore *tmux* ${DOTFILES_DIR}); do
		ALL_DOTFILES+="${filename} "
	done
	ALL_DOTFILES+="$(tmux_file)"
	echo ${ALL_DOTFILES}
}


while (( "$#" )); do
	if [[ $1 == "-h" ]] || [[ $1 == "--help" ]] || [[ $(echo $1 | cut -c-2) != "--" ]]; then usage; fi

	if [[ $(echo $1 | cut -c-5) == "--no-" ]]; then
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
			DOTFILES+=" $(ls ${DOTFILES_DIR} | grep ${pattern})"
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
      home_name="${HOME}/.${name}"
    fi

    echo "  - ${DOTFILES_DIR}/${name} => ${home_name}"
    rm -rf "${home_name}"
    ln -s "${DOTFILES_DIR}/${name}" "${home_name}"
  done
}

packages=($(needed_dependencies))
if [[ ${#packages[@]} > 0 ]]; then
  cmd_step "installing dependencies (${packages})" get_dependencies
else
  echo "all dependencies exist"
fi

cmd_step "linking_dotfiles" link_files

# Clone base dotfiles from braintree
if [[ ! -z $(echo ${DOTFILES} | grep vim) ]]; then
	if [ ! -d vim_dotfiles ]; then
		cmd_step "cloning braintreeps/vim_dotfiles" git clone https://github.com/braintreeps/vim_dotfiles
	fi

	cmd_step "updating braintreeps/vim_dotfiles" cd vim_dotfiles && git pull origin master
	cmd_step "activating all the things" bash activate.sh
fi

if [[ $(ps aux | grep tmux | grep -v grep) ]] && [[ ! -z $(echo ${DOTFILES} | grep tmux) ]]; then
  cmd_step "reloading tmux.conf"
  tmux source ${HOME}/.tmux.conf > /dev/null 2>&1
fi

echo "Success!"
