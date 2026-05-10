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
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install --cask ghostty
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm ghostty ;;
            apt)
                warn "ghostty is not in the default apt repos"
                info "See https://ghostty.org/docs/install for Debian/Ubuntu instructions"
                return
                ;;
            dnf)
                warn "ghostty is not in the default dnf repos"
                info "See https://ghostty.org/docs/install for Fedora instructions"
                return
                ;;
            zypper)
                warn "ghostty is not in the default zypper repos"
                info "See https://ghostty.org/docs/install for openSUSE instructions"
                return
                ;;
        esac
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
    local os
    os="$(detect_os)"

    if [ "$os" = "mac" ]; then
        if ! command_exists brew; then
            err "Homebrew is required on macOS. Install it from https://brew.sh"
        fi
        brew install --cask font-caskaydia-cove-nerd-font
    else
        local pkg
        pkg="$(detect_linux_pkg_manager)"
        case "$pkg" in
            pacman) sudo pacman -S --noconfirm ttf-cascadia-code-nerd ;;
            *)
                # Manual install for distros without a packaged version
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
                ;;
        esac
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

    install_stow
    install_ghostty
    install_nerd_font
    stow_module "ghostty" "$DOTFILES_DIR"

    echo
    ok "ghostty setup complete!"
}

main
