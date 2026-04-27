#!/usr/bin/env bash
# Shared helper functions sourced by all module install scripts.
# Usage: source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/helpers.sh"

# --- Logging ---

info()  { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
ok()    { printf '\033[1;32m[ok]\033[0m    %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
err()   { printf '\033[1;31m[error]\033[0m %s\n' "$*"; exit 1; }

# --- Detection ---

command_exists() { command -v "$1" &>/dev/null; }

detect_os() {
    case "$(uname -s)" in
        Linux*)  echo "linux" ;;
        Darwin*) echo "mac" ;;
        *)       err "Unsupported OS: $(uname -s)" ;;
    esac
}

detect_linux_pkg_manager() {
    if command_exists pacman; then
        echo "pacman"
    elif command_exists apt-get; then
        echo "apt"
    elif command_exists dnf; then
        echo "dnf"
    elif command_exists zypper; then
        echo "zypper"
    else
        err "No supported package manager found (pacman, apt, dnf, zypper)"
    fi
}

# --- Common installs ---

install_stow() {
    if command_exists stow; then
        ok "stow is already installed"
        return
    fi

    info "Installing stow..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install stow
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm stow ;;
            apt)    sudo apt-get update && sudo apt-get install -y stow ;;
            dnf)    sudo dnf install -y stow ;;
            zypper) sudo zypper install -y stow ;;
        esac
    fi

    if command_exists stow; then
        ok "stow installed"
    else
        err "stow installation failed"
    fi
}

# Stow a single module from the dotfiles repo into $HOME.
# Usage: stow_module <module_name> <dotfiles_dir>
stow_module() {
    local name="$1"
    local dotfiles_dir="$2"

    info "Stowing $name config..."
    if [ -n "${STOW_REPLACE:-}" ]; then
        stow -d "$dotfiles_dir" -t "$HOME" --adopt "$name"
        git -C "$dotfiles_dir" checkout -- "$name"
    else
        stow -d "$dotfiles_dir" -t "$HOME" ${STOW_ADOPT:+"$STOW_ADOPT"} "$name"
    fi
    ok "$name config stowed"
}
