#! /bin/bash
git submodule update --init --recursive
ansible-playbook main.yml
