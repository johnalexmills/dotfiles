#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

# --- Install fish ---

install_fish() {
    install_package fish
}

# --- Install zoxide ---

install_zoxide() {
    if command_exists zoxide; then
        ok "zoxide is already installed ($(zoxide --version))"
        return
    fi

    info "Installing zoxide..."
    if [ "$(detect_os)" = "mac" ]; then
        ensure_brew
        brew install zoxide
    else
        case "$(detect_linux_pkg_manager)" in
            pacman|dnf) pkg_install zoxide ;;
            apt|zypper) curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh ;;
        esac
    fi

    if command_exists zoxide; then
        ok "zoxide installed ($(zoxide --version))"
    else
        err "zoxide installation failed"
    fi
}

# --- Install fisher and plugins ---

install_fisher_plugins() {
    if ! command_exists fish; then
        warn "fish not found, skipping fisher/plugin install"
        return
    fi

    if fish -c 'type -q fisher' 2>/dev/null; then
        ok "fisher is already installed"
    else
        info "Installing fisher..."
        fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
        ok "fisher installed"
    fi

    local plugins_file="$HOME/.config/fish/fish_plugins"
    if [ -f "$plugins_file" ]; then
        info "Installing fish plugins from fish_plugins..."
        fish -c 'fisher update'
        ok "Fish plugins installed"
    else
        warn "No fish_plugins file found, skipping plugin install"
    fi
}

# --- Main ---

main() {
    info "Setting up fish..."
    echo

    install_fish
    install_zoxide
    stow_module "fish" "$DOTFILES_DIR"
    install_fisher_plugins

    echo
    ok "fish setup complete!"
    info "Restart your terminal or run: fish"
}

main
