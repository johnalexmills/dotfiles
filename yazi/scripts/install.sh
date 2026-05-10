#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

# --- Install yazi ---

install_yazi() {
    if command_exists yazi; then
        ok "yazi is already installed ($(yazi --version | head -1))"
        return
    fi

    info "Installing yazi..."
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install yazi
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm yazi ;;
            apt)
                warn "yazi is not in the standard apt repos. Installing via cargo..."
                warn "Note: yazi has optional runtime deps for full functionality:"
                warn "  file, ffmpegthumbnailer, unar, jq, poppler-utils, fd-find,"
                warn "  ripgrep, fzf, zoxide, imagemagick"
                warn "Install them with: sudo apt-get install -y <deps>"
                if command_exists cargo; then
                    cargo install --locked yazi-fm yazi-cli
                else
                    err "yazi requires cargo on Debian/Ubuntu. Install Rust from https://rustup.rs"
                fi
                ;;
            dnf)    sudo dnf install -y yazi ;;
            zypper) sudo zypper install -y yazi ;;
        esac
    fi

    if command_exists yazi; then
        ok "yazi installed ($(yazi --version | head -1))"
    else
        err "yazi installation failed"
    fi
}

# --- Install yazi catppuccin-mocha flavor ---

install_yazi_flavor() {
    if ! command_exists ya; then
        warn "ya (yazi package manager) not found, skipping flavor install"
        info "After yazi is fully installed, run: ya pkg add yazi-rs/flavors:catppuccin-mocha"
        return
    fi

    local flavor_dir="$HOME/.config/yazi/flavors/catppuccin-mocha.yazi"
    if [ -d "$flavor_dir" ]; then
        ok "catppuccin-mocha flavor already installed"
        return
    fi

    info "Installing catppuccin-mocha yazi flavor..."
    ya pkg add yazi-rs/flavors:catppuccin-mocha
    ok "catppuccin-mocha flavor installed"
}

# --- Main ---

main() {
    info "Setting up yazi..."
    echo

    install_stow
    install_yazi
    stow_module "yazi" "$DOTFILES_DIR"
    install_yazi_flavor

    echo
    ok "yazi setup complete!"
    info "Launch with: yazi"
}

main
