#! /bin/bash
set -e
git submodule update --init --recursive
ansible-playbook --ask-become-pass main.yml "$@" 
