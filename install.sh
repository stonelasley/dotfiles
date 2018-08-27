#! /bin/bash
git submodule update --init --recursive
ansible-playbook --ask-sudo-pass main.yml "$@" 
