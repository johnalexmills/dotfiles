#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

# --- Install ghostty ---

install_ghostty() {
    if command_exists ghostty; then
        ok "ghostty is already installed"
        return
    fi

    info "Installing ghostty..."
    if [ "$(detect_os)" = "mac" ]; then
        ensure_brew
        brew install --cask ghostty
    elif [ "$(detect_linux_pkg_manager)" = "pacman" ]; then
        pkg_install ghostty
    else
        warn "ghostty is not in the default repos"
        info "See https://ghostty.org/docs/install for your distro's instructions"
        return
    fi

    if command_exists ghostty; then
        ok "ghostty installed"
    else
        err "ghostty installation failed"
    fi
}

# --- Install nerd font ---

install_nerd_font() {
    local font_name="CaskaydiaCove"

    if ! command_exists fc-list; then
        warn "fc-list not found, can't verify font installation; will attempt install anyway"
    elif fc-list | grep -qi "$font_name"; then
        ok "CaskaydiaCove Nerd Font is already installed"
        return
    fi

    info "Installing CaskaydiaCove Nerd Font..."
    if [ "$(detect_os)" = "mac" ]; then
        ensure_brew
        brew install --cask font-caskaydia-cove-nerd-font
    elif [ "$(detect_linux_pkg_manager)" = "pacman" ]; then
        pkg_install ttf-cascadia-code-nerd
    else
        local font_dir="$HOME/.local/share/fonts"
        local tmp_dir
        tmp_dir="$(mktemp -d)"

        info "Downloading CaskaydiaCove Nerd Font..."
        curl -fsSL -o "$tmp_dir/CaskaydiaCove.zip" \
            "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip"

        mkdir -p "$font_dir"
        unzip -qo "$tmp_dir/CaskaydiaCove.zip" -d "$font_dir"
        rm -rf "$tmp_dir"

        if command_exists fc-cache; then
            fc-cache -f "$font_dir"
        fi
    fi

    if command_exists fc-list && fc-list | grep -qi "$font_name"; then
        ok "CaskaydiaCove Nerd Font installed"
    else
        warn "Could not verify font installation (may need to restart your session)"
    fi
}

# --- Main ---

main() {
    info "Setting up ghostty..."
    echo

    install_ghostty
    install_nerd_font
    stow_module "ghostty" "$DOTFILES_DIR"

    echo
    ok "ghostty setup complete!"
}

main
