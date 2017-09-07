This contains extra dotfiles, including 'local' vimrc/vim plugins.
The vim additions are meant to be loaded along side https://github.com/braintreeps/vim_dotfiles


Install
-------

```
$ git clone https://github.com/fdm1/frank_dotfiles
$ ./frank_dotfiles/activate.sh
```

This will symlink all personal files to the root directory, clone braintreeps/vim_dotfiles (if needed), pull that repo,
and activate/install everything.

Requirements / Setup
--------------------

Requires:
* git
* sudo

This will install/update the following packages (if needed):
* vim (upgrade to 8.0+)
* tmux
* wget
* curl
