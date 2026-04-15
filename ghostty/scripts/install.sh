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

    # Check if font is already installed
    if fc-list 2>/dev/null | grep -qi "$font_name"; then
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

                fc-cache -f "$font_dir"
                ;;
        esac
    fi

    if fc-list 2>/dev/null | grep -qi "$font_name"; then
        ok "CaskaydiaCove Nerd Font installed"
    else
        warn "Could not verify font installation (may need to restart your session)"
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

    info "Stowing ghostty config..."
    if [ -n "${STOW_REPLACE:-}" ]; then
        stow -d "$dotfiles_dir" -t "$HOME" --adopt ghostty
        git -C "$dotfiles_dir" checkout -- ghostty
    else
        stow -d "$dotfiles_dir" -t "$HOME" ${STOW_ADOPT:+"$STOW_ADOPT"} ghostty
    fi
    ok "ghostty config stowed"
}

# --- Main ---

main() {
    info "Setting up ghostty..."
    echo

    install_stow
    install_ghostty
    install_nerd_font
    stow_config

    echo
    ok "ghostty setup complete!"
}

main
