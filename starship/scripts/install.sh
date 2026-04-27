#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

# --- Install starship ---

install_starship() {
    if command_exists starship; then
        ok "starship is already installed ($(starship --version | head -1))"
        return
    fi

    info "Installing starship..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install starship
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm starship ;;
            apt)    curl -sS https://starship.rs/install.sh | sh -s -- -y ;;
            dnf)    sudo dnf install -y starship ;;
            zypper) curl -sS https://starship.rs/install.sh | sh -s -- -y ;;
        esac
    fi

    if command_exists starship; then
        ok "starship installed ($(starship --version | head -1))"
    else
        err "starship installation failed"
    fi
}

# --- Main ---

main() {
    info "Setting up starship..."
    echo

    install_stow
    install_starship
    stow_module "starship" "$(cd "$SCRIPT_DIR/../.." && pwd)"

    echo
    ok "starship setup complete!"
    info "Make sure your shell initialises starship (handled by fish config)"
}

main
