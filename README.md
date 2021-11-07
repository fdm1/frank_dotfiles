Install
-------

Install ansible (however necessary)

```
./run_ansible.sh
```

This will ensure `~/.my_{config_file_name}` is sourced in the main config files (e.g. `~/.bashrc`)

The `~/.my_*` variants will then source all the individual files needed based on the computer being used (determined by OS), effectively composing a total configuration. This allows for things like Windows (with WSL2) to have both the basic Ubuntu configuration, plus some configuration specific to my WSL2 dev environment, and any other specific combination of desired configs.

Requirements / Setup
--------------------

Requires:
* ansible

Limitations / TODOS
-------------------

- This currently does not install any packages. It assumes you have nvim, git, and tmux already installed. That will come later.

- install homebrew

- install other things
  - rvm (via curl)
  - ruby 3.0.2 (via rvm)
  - ruby 2.7.4 (via rvm)
  - neovim gem (globally)
  - yarn (via npm) 
  - npm neovim (via npm)
  - python 3.9.7 via pyenv (PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 3.9.7 )
  - pip3.9 install neovim
  - cd ~/.config/nvim/plugged/YouCompleteMe && python3.9 install.py
  - python 3.10.0 via pyenv (PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 3.10.0 )
  - pip3.10 install neovim
  - pyenv global 3.10.0
  - cd ~/.config/nvim/plugged/YouCompleteMe && python3.10 install.py

- add Base init.vim file
- setup vim plug autoload stuff

- Separate `macosx` OS with `root` so I can have personal and work-specific mac configs
