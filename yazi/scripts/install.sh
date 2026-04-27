#!/usr/bin/env bash
set -euo pipefail

# --- Helpers ---

info()  { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
ok()    { printf '\033[1;32m[ok]\033[0m    %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
err()   { printf '\033[1;31m[error]\033[0m %s\n' "$*"; exit 1; }

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

# --- Install yazi ---

install_yazi() {
    if command_exists yazi; then
        ok "yazi is already installed ($(yazi --version | head -1))"
        return
    fi

    info "Installing yazi..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install yazi
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm yazi ;;
            apt)
                warn "yazi is not in the standard apt repos. Installing via cargo..."
                if command_exists cargo; then
                    cargo install --locked yazi-fm yazi-cli
                else
                    err "yazi requires cargo on Debian/Ubuntu. Install Rust from https://rustup.rs"
                fi
                ;;
            dnf)    sudo dnf install -y yazi ;;
            zypper) sudo zypper install -y yazi ;;
        esac
    fi

    if command_exists yazi; then
        ok "yazi installed ($(yazi --version | head -1))"
    else
        err "yazi installation failed"
    fi
}

# --- Install stow ---

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

# --- Stow config ---

stow_config() {
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dotfiles_dir="$script_dir/../.."
    dotfiles_dir="$(cd "$dotfiles_dir" && pwd)"

    info "Stowing yazi config..."
    if [ -n "${STOW_REPLACE:-}" ]; then
        stow -d "$dotfiles_dir" -t "$HOME" --adopt yazi
        git -C "$dotfiles_dir" checkout -- yazi
    else
        stow -d "$dotfiles_dir" -t "$HOME" ${STOW_ADOPT:+"$STOW_ADOPT"} yazi
    fi
    ok "yazi config stowed"
}

# --- Main ---

main() {
    info "Setting up yazi..."
    echo

    install_stow
    install_yazi
    stow_config

    echo
    ok "yazi setup complete!"
    info "Launch with: yazi"
}

main
