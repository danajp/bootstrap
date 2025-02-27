# Bootstrap a new machine with ansible

This bootstraps a fresh Ubuntu install for me.

## Prerequisites

- running Ubuntu 24.04 LTS
- Your username is `dana`
- `dana` is in the `sudo` group which allows him to do anything

## From a fresh installation

1. [Download](https://1password.com/downloads/linux), install and setup 1password desktop app.
1. [Configure 1password SSH agent](https://1password.com/downloads/linux)
1. [Configure git commit signing with SSH](https://developer.1password.com/docs/ssh/git-commit-signing) and put the suggested git config snippet into `~/.gitconfig-signing` (my regular `~/.gitconfig` will include this file)
1. Install packages required to run make/ansible:
   `sudo apt update && sudo apt install make git ansible zsh`
1. Set default shell to zsh `chsh -s $(which zsh)`
1. Clone this repo
1. `make base` to install system packages (surely, this will run without error the first time)
1. `make user` to install user specific configuration
1. Reboot or at least restart window manager to switch to regolith/i3

## Roles

### Base

Installs OS packages and various OS level configuration.

### User

Performs user specific tasks for `dana`, such as:

- clones and installs [dotfiles](https://github.com/danajp/dotfiles)
- clones [dotemacs](https://github.com/danajp/dotemacs)
- sets up asdf and plugins
- handles various other user specific tooling/configuration
