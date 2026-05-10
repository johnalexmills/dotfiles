#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

# --- Install fish ---

install_fish() {
    if command_exists fish; then
        ok "fish is already installed ($(fish --version))"
        return
    fi

    info "Installing fish..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install fish
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm fish ;;
            apt)    sudo apt-get update && sudo apt-get install -y fish ;;
            dnf)    sudo dnf install -y fish ;;
            zypper) sudo zypper install -y fish ;;
        esac
    fi

    if command_exists fish; then
        ok "fish installed ($(fish --version))"
    else
        err "fish installation failed"
    fi
}

# --- Install starship (also handled by starship module; kept here so fish-only
#     install still results in a working prompt). ---

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

# --- Install zoxide ---

install_zoxide() {
    if command_exists zoxide; then
        ok "zoxide is already installed ($(zoxide --version))"
        return
    fi

    info "Installing zoxide..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install zoxide
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm zoxide ;;
            apt)    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh ;;
            dnf)    sudo dnf install -y zoxide ;;
            zypper) curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh ;;
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

    install_stow
    install_fish
    install_starship
    install_zoxide
    stow_module "fish" "$DOTFILES_DIR"
    stow_module "starship" "$DOTFILES_DIR"
    install_fisher_plugins

    echo
    ok "fish setup complete!"
    info "Restart your terminal or run: fish"
}

main
