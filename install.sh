#!/bin/bash
set -euo pipefail

readonly SCRIPT_NAME="$(basename "$0")"
readonly OS_TYPE="$(uname -s)"

log() {
    echo "[${SCRIPT_NAME}] $*" >&2
}

error() {
    log "ERROR: $*"
    exit 1
}

check_dependencies() {
    log "Checking dependencies..."
    
    if ! command -v git >/dev/null 2>&1; then
        error "git is required but not installed"
    fi
    
    case "$OS_TYPE" in
        Darwin)
            if ! command -v brew >/dev/null 2>&1; then
                error "Homebrew is required on macOS. Install from https://brew.sh"
            fi
            ;;
        Linux)
            if ! command -v apt >/dev/null 2>&1; then
                error "apt package manager is required on Linux"
            fi
            ;;
        *)
            error "Unsupported operating system: $OS_TYPE"
            ;;
    esac
}

install_ansible() {
    if command -v ansible >/dev/null 2>&1; then
        log "Ansible is already installed"
        return 0
    fi
    
    log "Installing Ansible..."
    case "$OS_TYPE" in
        Darwin)
            log "Updating Homebrew..."
            brew update
            log "Installing Ansible via Homebrew..."
            brew install ansible
            ;;
        Linux)
            log "Updating package lists..."
            sudo apt update
            log "Installing Ansible via apt..."
            sudo apt install -y ansible
            ;;
    esac
    
    log "Ansible installation completed"
}

setup_submodules() {
    log "Initializing git submodules..."
    git submodule update --init --recursive
}

install_ansible_collections() {
    log "Installing required Ansible collections..."
    ansible-galaxy collection install community.general --force
}

run_playbook() {
    log "Running Ansible playbook..."
    ansible-playbook --ask-become-pass main.yml "$@"
}

main() {
    log "Starting dotfiles installation..."
    
    check_dependencies
    install_ansible
    setup_submodules
    install_ansible_collections
    run_playbook "$@"
    
    log "Installation completed successfully!"
}

main "$@" 
