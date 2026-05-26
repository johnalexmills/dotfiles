#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

# --- macOS only ---

if [ "$(detect_os)" != "mac" ]; then
    warn "AeroSpace is macOS only — skipping"
    exit 0
fi

# --- Install AeroSpace ---

install_aerospace() {
    install_package aerospace --cask nikitabobko/tap/aerospace
}

# --- Main ---

main() {
    info "Setting up AeroSpace..."
    echo

    install_aerospace
    stow_module aerospace "$DOTFILES_DIR"

    echo
    ok "AeroSpace setup complete!"
    info "Reload config with: aerospace reload-config"
    info "Or use alt-shift-semicolon from within AeroSpace"
}

main
