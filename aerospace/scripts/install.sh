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
    if command_exists aerospace; then
        ok "AeroSpace is already installed ($(aerospace --version))"
        return
    fi

    info "Installing AeroSpace..."

    if ! command_exists brew; then
        err "Homebrew is required on macOS. Install it from https://brew.sh"
    fi

    brew install --cask nikitabobko/tap/aerospace

    if command_exists aerospace; then
        ok "AeroSpace installed ($(aerospace --version))"
    else
        err "AeroSpace installation failed"
    fi
}

# --- Main ---

main() {
    info "Setting up AeroSpace..."
    echo

    install_stow
    install_aerospace
    stow_module aerospace "$DOTFILES_DIR"

    echo
    ok "AeroSpace setup complete!"
    info "Reload config with: aerospace reload-config"
    info "Or use alt-shift-semicolon from within AeroSpace"
}

main
