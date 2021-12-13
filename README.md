Install
-------

Install ansible (`brew install ansible`)

```
./run_ansible.sh
```

Requirements / Setup
--------------------

Requires:
* ansible

TODOS
-------------------

- This currently does not install any packages. It assumes you have nvim, git, and tmux already installed. That will come later.

- install homebrew
- install other things
  - neovim gem (globally)
  - yarn (via npm)
  - npm neovim (via npm)

- ensure PYTHON_CONFIGURE_OPTS="--enable-framework" when installing python (for installing youcompleteme)
- allow xcodes install to fail
- install neovim stuff (python3.9 package, npm package, ruby gem) so healthcheck is fine
- set global rbenv ruby version
