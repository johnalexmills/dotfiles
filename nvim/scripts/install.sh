#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

# --- Install neovim ---

install_neovim() {
    if command_exists nvim; then
        ok "neovim is already installed ($(nvim --version | head -1))"
        return
    fi

    info "Installing neovim..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install neovim
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm neovim ;;
            apt)    sudo apt-get update && sudo apt-get install -y neovim ;;
            dnf)    sudo dnf install -y neovim ;;
            zypper) sudo zypper install -y neovim ;;
        esac
    fi

    if command_exists nvim; then
        ok "neovim installed ($(nvim --version | head -1))"
    else
        err "neovim installation failed"
    fi
}

# --- Install tree-sitter CLI ---

install_tree_sitter() {
    if command_exists tree-sitter; then
        ok "tree-sitter CLI is already installed ($(tree-sitter --version))"
        return
    fi

    info "Installing tree-sitter CLI..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install tree-sitter
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm tree-sitter-cli ;;
            *)
                if command_exists cargo; then
                    cargo install tree-sitter-cli
                elif command_exists npm; then
                    npm install -g tree-sitter-cli
                else
                    err "tree-sitter-cli requires cargo or npm on this distro"
                fi
                ;;
        esac
    fi

    if command_exists tree-sitter; then
        ok "tree-sitter CLI installed ($(tree-sitter --version))"
    else
        err "tree-sitter CLI installation failed"
    fi
}

# --- Sync plugins ---

sync_plugins() {
    if ! command_exists nvim; then
        warn "neovim not found, skipping plugin sync"
        return
    fi

    info "Syncing plugins via lazy.nvim (this may take a moment)..."
    nvim --headless "+Lazy! sync" +qa 2>&1 || true
    ok "Plugins synced"

    info "Updating treesitter parsers..."
    nvim --headless "+TSUpdate" +qa 2>&1 || true
    ok "Treesitter parsers updated"
}

# --- Main ---

main() {
    info "Setting up neovim..."
    echo

    install_stow
    install_neovim
    install_tree_sitter
    stow_module "nvim" "$DOTFILES_DIR"
    sync_plugins

    echo
    ok "neovim setup complete!"
    info "Launch with: nvim"
    info "Run :checkhealth to verify everything is working"
    info "Mason will auto-install LSP servers, formatters, and linters on first file open"
}

main
