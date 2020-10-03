#! /bin/bash
set -e

if ! [ -x "$(command -v ansible)" ]; then
  sudo apt update  && sudo apt install ansible
fi

git submodule update --init --recursive
ansible-playbook --ask-become-pass main.yml "$@" 
