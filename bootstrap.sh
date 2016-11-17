#!/bin/bash

info() {
  echo "INFO $1" >&2
}

info "install ansible"
sudo apt-get update
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y ansible

info "generate ssh key"
ssh-keygen
