### bash:

If not root:
  - Add line to ~/.bash_profile to source ~/.my_profile

Generate ~/.my_profile

For each section to include (including `base`), add the following line:

```
for i in dotfiles/bash/{section}/*; do source $i; do
```

### git:

Symlink ~/.gitignore_global

if not root:
  - create ~/.gitconfig

generate ~/my_gitconfig

```
[include]
  path = resources/git/{section}/gitconfig
```

### nvim:

If not root:
  - symlink nvim dir to ~/.config/nvim


create my_nvimrc
```
if filereadable(expand("resources/nvim/{section}/nvimrc"))
  source nvim/{section}/nvimrc
endif
```

create my_nvim_plugins
```
if filereadable(expand("resources/nvim/{section}/nvim_plugins"))
  source nvim/{section}/nvim_plugins
endif
```

### tmux

if not root, generate tmux.conf:

```
if-shell 'test -f ~/.my_tmux.conf' 'source ~/.my_tmux.conf'
```

generate ~/.my_tmux.conf

```
if-shell 'test -f resources/tmux/{section}/tmux.conf' 'source resources/tmux/{section}/tmux.con'
```

### bin scripts:

For each section, add to ~/.my_profile

```
echo PATH=$PATH:resources/bin_scripts/{section}/
```

### packages:
install packages from yml for system if yml exists

```
- type of package (e.g apt-get):
  - package1
  - package1
- other type (e.g. pip):
  - ansible
  - foo
```
