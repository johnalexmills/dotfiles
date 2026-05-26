#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

# --- Install starship ---

install_starship() {
    if command_exists starship; then
        ok "starship is already installed ($(starship --version | head -1))"
        return
    fi

    info "Installing starship..."
    if [ "$(detect_os)" = "mac" ]; then
        ensure_brew
        brew install starship
    else
        case "$(detect_linux_pkg_manager)" in
            pacman|dnf) pkg_install starship ;;
            apt|zypper) curl -sS https://starship.rs/install.sh | sh -s -- -y ;;
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

    install_starship
    stow_module "starship" "$DOTFILES_DIR"

    echo
    ok "starship setup complete!"
    info "Make sure your shell initialises starship (handled by fish config)"
}

main
