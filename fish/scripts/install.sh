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

# --- Install starship ---

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

    info "Stowing fish config..."
    if [ -n "${STOW_REPLACE:-}" ]; then
        stow -d "$dotfiles_dir" -t "$HOME" --adopt fish
        git -C "$dotfiles_dir" checkout -- fish
    else
        stow -d "$dotfiles_dir" -t "$HOME" ${STOW_ADOPT:+"$STOW_ADOPT"} fish
    fi
    ok "fish config stowed"

    info "Stowing starship config..."
    if [ -n "${STOW_REPLACE:-}" ]; then
        stow -d "$dotfiles_dir" -t "$HOME" --adopt starship
        git -C "$dotfiles_dir" checkout -- starship
    else
        stow -d "$dotfiles_dir" -t "$HOME" ${STOW_ADOPT:+"$STOW_ADOPT"} starship
    fi
    ok "starship config stowed"
}

# --- Install fisher and plugins ---

install_fisher_plugins() {
    if ! command_exists fish; then
        warn "fish not found, skipping fisher/plugin install"
        return
    fi

    # Install fisher if not present
    if fish -c 'type -q fisher' 2>/dev/null; then
        ok "fisher is already installed"
    else
        info "Installing fisher..."
        fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
        ok "fisher installed"
    fi

    # Install plugins from fish_plugins
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
    stow_config
    install_fisher_plugins

    echo
    ok "fish setup complete!"
    info "Restart your terminal or run: fish"
}

main
