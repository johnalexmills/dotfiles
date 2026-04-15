#!/usr/bin/env bash
set -euo pipefail

# --- Helpers ---

info()  { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
ok()    { printf '\033[1;32m[ok]\033[0m    %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
err()   { printf '\033[1;31m[error]\033[0m %s\n' "$*"; exit 1; }

command_exists() { command -v "$1" &>/dev/null; }

detect_os() {
    case "$(uname -s)" in
        Linux*)  echo "linux" ;;
        Darwin*) echo "mac" ;;
        *)       err "Unsupported OS: $(uname -s)" ;;
    esac
}

detect_linux_pkg_manager() {
    if command_exists pacman; then
        echo "pacman"
    elif command_exists apt-get; then
        echo "apt"
    elif command_exists dnf; then
        echo "dnf"
    elif command_exists zypper; then
        echo "zypper"
    else
        err "No supported package manager found (pacman, apt, dnf, zypper)"
    fi
}

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
            apt)
                if command_exists cargo; then
                    cargo install tree-sitter-cli
                elif command_exists npm; then
                    npm install -g tree-sitter-cli
                else
                    err "tree-sitter-cli requires cargo or npm on Debian/Ubuntu"
                fi
                ;;
            dnf)
                if command_exists cargo; then
                    cargo install tree-sitter-cli
                elif command_exists npm; then
                    npm install -g tree-sitter-cli
                else
                    err "tree-sitter-cli requires cargo or npm on Fedora"
                fi
                ;;
            zypper)
                if command_exists cargo; then
                    cargo install tree-sitter-cli
                elif command_exists npm; then
                    npm install -g tree-sitter-cli
                else
                    err "tree-sitter-cli requires cargo or npm on openSUSE"
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

# --- Install stow ---

install_stow() {
    if command_exists stow; then
        ok "stow is already installed"
        return
    fi

    info "Installing stow..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install stow
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm stow ;;
            apt)    sudo apt-get update && sudo apt-get install -y stow ;;
            dnf)    sudo dnf install -y stow ;;
            zypper) sudo zypper install -y stow ;;
        esac
    fi

    if command_exists stow; then
        ok "stow installed"
    else
        err "stow installation failed"
    fi
}

# --- Stow config ---

stow_config() {
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dotfiles_dir="$script_dir/../.."

    # Resolve to absolute path
    dotfiles_dir="$(cd "$dotfiles_dir" && pwd)"

    info "Stowing nvim config..."
    stow -d "$dotfiles_dir" -t "$HOME" nvim
    ok "nvim config stowed"
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
    stow_config
    sync_plugins

    echo
    ok "neovim setup complete!"
    info "Launch with: nvim"
    info "Run :checkhealth to verify everything is working"
    info "Mason will auto-install LSP servers, formatters, and linters on first file open"
}

main
