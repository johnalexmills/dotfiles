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
#
# The flavor itself is downloaded by `ya` at runtime; only its declaration in
# package.toml is tracked in dotfiles. Pick the right `ya` subcommand:
#   - declared in package.toml + dir missing → `ya pkg install` (materialise)
#   - not declared                            → `ya pkg add`     (declare + install)
#   - dir present                             → nothing to do
# All ya invocations are made non-fatal so a flavor hiccup never aborts the
# rest of the dotfiles install.

install_yazi_flavor() {
    local pkg="yazi-rs/flavors:catppuccin-mocha"
    local pkg_toml="$HOME/.config/yazi/package.toml"
    local flavor_dir="$HOME/.config/yazi/flavors/catppuccin-mocha.yazi"

    if ! command_exists ya; then
        warn "ya (yazi package manager) not found, skipping flavor install"
        info "After yazi is fully installed, run: ya pkg install || ya pkg add $pkg"
        return 0
    fi

    if [ -d "$flavor_dir" ]; then
        ok "catppuccin-mocha flavor already materialised"
        return 0
    fi

    if [ -f "$pkg_toml" ] && grep -q "$pkg" "$pkg_toml" 2>/dev/null; then
        info "Materialising yazi flavors declared in package.toml..."
        ya pkg install || warn "ya pkg install failed (non-fatal)"
    else
        info "Adding + installing catppuccin-mocha yazi flavor..."
        ya pkg add "$pkg" || warn "ya pkg add failed (non-fatal)"
    fi

    if [ -d "$flavor_dir" ]; then
        ok "catppuccin-mocha flavor installed"
    else
        warn "catppuccin-mocha flavor not present after install attempt"
        info "Try manually: ya pkg install"
    fi
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
