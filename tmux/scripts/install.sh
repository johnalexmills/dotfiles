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

# --- Install tmux ---

install_tmux() {
    if command_exists tmux; then
        ok "tmux is already installed ($(tmux -V))"
        return
    fi

    info "Installing tmux..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install tmux
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm tmux ;;
            apt)    sudo apt-get update && sudo apt-get install -y tmux ;;
            dnf)    sudo dnf install -y tmux ;;
            zypper) sudo zypper install -y tmux ;;
        esac
    fi

    if command_exists tmux; then
        ok "tmux installed ($(tmux -V))"
    else
        err "tmux installation failed"
    fi
}

# --- Install TPM ---

install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [ -d "$tpm_dir" ]; then
        ok "TPM is already installed"
        return
    fi

    if ! command_exists git; then
        err "git is required to install TPM"
    fi

    info "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    ok "TPM installed"
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

    # Resolve to absolute path
    dotfiles_dir="$(cd "$dotfiles_dir" && pwd)"

    info "Stowing tmux config..."
    stow -d "$dotfiles_dir" -t "$HOME" tmux
    ok "tmux config stowed"
}

# --- Install plugins ---

install_plugins() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [ ! -x "$tpm_dir/bin/install_plugins" ]; then
        warn "TPM install script not found, skipping plugin install"
        info "Start tmux and press prefix + I to install plugins manually"
        return
    fi

    info "Installing tmux plugins..."
    "$tpm_dir/bin/install_plugins"
    ok "Plugins installed"
}

# --- Main ---

main() {
    info "Setting up tmux..."
    echo

    install_stow
    install_tmux
    install_tpm
    stow_config
    install_plugins

    echo
    ok "tmux setup complete!"
    info "Start a session with: tn main"
    info "Attach to a session with: ta main"
    info "List sessions with: tl"
    info "Kill a session with: tk main"
}

main
