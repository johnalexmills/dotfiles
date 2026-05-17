#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

main() {
    info "Setting up opencode..."
    echo

    install_stow

    if ! command_exists opencode; then
        warn "opencode not installed. Config will be stowed regardless. Install from https://opencode.ai"
    else
        ok "opencode found ($(opencode --version 2>/dev/null | head -1))"
    fi

    stow_module "opencode" "$DOTFILES_DIR"

    echo
    ok "opencode setup complete!"
    info "Restart any running opencode sessions to pick up config changes."
}

main
