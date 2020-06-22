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

- Eventually separate `macosx` OS with `root` so I can have personal and work-specific mac configs (if I ever have a personal mac)
