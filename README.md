# Bootstrap a new machine with ansible

This bootstraps a fresh Ubuntu install for me.

## Assumptions

- using Ubuntu 22.04 LTS
- Your username is `dana`
- ssh key is stored as a 1password document called `ssh-private-key`
- `dana` is in the `sudo` group which allows him to do anything

## From a fresh installation

1. Configure some things via the WYSIWYG control center:
   - Display resolution/external display
   - Bluetooth devices
   - Power saving/screen blanking
   - Wifi
1. Update any outdated packages and install prerequisites:
   `sudo apt update && sudo apt install make git tmux unzip curl emacs && sudo apt upgrade`
1. Reboot (we likely got a new kernel in the previous step)
1. Copy secrets repo into `~/secrets` and `make`
1. Clone this repo into `~/src/bootstrap`
1. Install the system packages
   `make base`
1. Install the user customizations
   `make user`

This will definitely go smoothly, requiring no modification to the playbooks or manual intervention.
