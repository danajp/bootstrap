# Bootstrap a new machine with ansible

This bootstraps a fresh Ubuntu install for me.

## Assumptions

- Ubuntu (only tested on 18.10)
- Your username is `dana`
- You have an ssh key that your github account knows about
- `dana` is in the `sudo` group which allows him to do anything

## How to run it

To install ansible and run the whole playbook:

`make`

To just install packages using the playbook:

`make packages`

Or just run the playbook and filter by tags:

`make tags TAGS=ruby`
