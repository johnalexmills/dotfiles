#!/usr/bin/env bash
set -euo pipefail

# --- Helpers ---

info()  { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
ok()    { printf '\033[1;32m[ok]\033[0m    %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
err()   { printf '\033[1;31m[error]\033[0m %s\n' "$*"; exit 1; }

command_exists() { command -v "$1" &>/dev/null; }

# --- macOS only ---

if [ "$(uname -s)" != "Darwin" ]; then
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

# --- Stow config ---

stow_config() {
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dotfiles_dir="$script_dir/../.."
    dotfiles_dir="$(cd "$dotfiles_dir" && pwd)"

    if ! command_exists stow; then
        err "stow is not installed. Run the main install.sh first."
    fi

    info "Stowing aerospace config..."
    if [ -n "${STOW_REPLACE:-}" ]; then
        stow -d "$dotfiles_dir" -t "$HOME" --adopt aerospace
        git -C "$dotfiles_dir" checkout -- aerospace
    else
        stow -d "$dotfiles_dir" -t "$HOME" ${STOW_ADOPT:+"$STOW_ADOPT"} aerospace
    fi
    ok "aerospace config stowed"
}

# --- Main ---

main() {
    info "Setting up AeroSpace..."
    echo

    install_aerospace
    stow_config

    echo
    ok "AeroSpace setup complete!"
    info "Reload config with: aerospace reload-config"
    info "Or use alt-shift-semicolon from within AeroSpace"
}

main
