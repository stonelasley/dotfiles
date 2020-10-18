#! /bin/bash
set -e

if ! [ -x "$(command -v ansible)" ]; then
  if [ "$(uname -s)" = "Darwin" ]
  then 
    echo "Updating Brew..."
    brew update
    echo "Installing Ansible..."
    brew install ansible
  else
    sudo apt update
    sudo apt install ansible -y
  fi
fi

git submodule update --init --recursive
ansible-playbook --ask-become-pass main.yml "$@" 
