#! /bin/bash
set -e
#if [ "$(uname -s)" = "Darwin" ] 
#then 
#  echo "Updating Brew..."
#  brew update
#  echo "Upgrading Brew..."
#  brew upgrade
#else
#  echo "Updating apt..."
#  sudo apt update -qq
#  echo "Upgrading apt..."
#  sudo apt upgrade -qq
#fi

if ! [ -x "$(command -v ansible)" ]; then
  if [ "$(uname -s)" = "Darwin" ]
  then 
    echo "Updating Brew..."
    brew update
    echo "Installing Ansible..."
    brew install ansible
  else
    echo "Updating apt..."
    sudo apt update
    sudo apt install ansible -y
  fi
fi

git submodule update --init --recursive
ansible-galaxy collection install community.general
ansible-playbook --ask-become-pass main.yml "$@" 
