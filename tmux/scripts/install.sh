#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

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
    local tpm_dir="$HOME/.config/tmux/plugins/tpm"

    # Remove stale symlink if present (e.g. leftover from a previous stow setup)
    if [ -L "$tpm_dir" ]; then
        warn "Removing stale symlink at $tpm_dir"
        rm "$tpm_dir"
    fi

    if [ -d "$tpm_dir" ]; then
        ok "TPM is already installed"
        return
    fi

    if ! command_exists git; then
        err "git is required to install TPM"
    fi

    info "Installing TPM (Tmux Plugin Manager)..."
    mkdir -p "$(dirname "$tpm_dir")"
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    ok "TPM installed"
}

# --- Install plugins ---

install_plugins() {
    local tpm_dir="$HOME/.config/tmux/plugins/tpm"

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
    stow_module "tmux" "$DOTFILES_DIR"
    install_plugins

    echo
    ok "tmux setup complete!"
    info "Start a session with: tn main"
    info "Attach to a session with: ta main"
    info "List sessions with: tl"
    info "Kill a session with: tk main"
}

main
