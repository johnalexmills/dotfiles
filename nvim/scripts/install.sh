#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

# --- Install neovim ---

install_neovim() {
    install_package nvim neovim
}

# --- Install tree-sitter CLI ---

install_tree_sitter() {
    if command_exists tree-sitter; then
        ok "tree-sitter CLI is already installed ($(tree-sitter --version))"
        return
    fi

    info "Installing tree-sitter CLI..."
    if [ "$(detect_os)" = "mac" ]; then
        ensure_brew
        brew install tree-sitter
    elif [ "$(detect_linux_pkg_manager)" = "pacman" ]; then
        pkg_install tree-sitter-cli
    else
        if command_exists cargo; then
            cargo install tree-sitter-cli
        elif command_exists npm; then
            npm install -g tree-sitter-cli
        else
            err "tree-sitter-cli requires cargo or npm on this distro"
        fi
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

    local log_file
    log_file="$(mktemp)"

    info "Syncing plugins via lazy.nvim (this may take a moment)..."
    if nvim --headless "+Lazy! sync" +qa >"$log_file" 2>&1; then
        ok "Plugins synced"
    else
        warn "Lazy sync had errors (full log: $log_file)"
    fi

    info "Updating treesitter parsers..."
    if nvim --headless "+TSUpdate" +qa >"$log_file" 2>&1; then
        ok "Treesitter parsers updated"
    else
        warn "TSUpdate had errors (full log: $log_file)"
    fi
}

# --- Main ---

main() {
    info "Setting up neovim..."
    echo

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
