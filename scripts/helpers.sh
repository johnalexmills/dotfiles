#!/usr/bin/env bash
# Shared helper functions sourced by all module install scripts.
# Usage: source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/scripts/helpers.sh"

# --- Logging ---

info()  { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
ok()    { printf '\033[1;32m[ok]\033[0m    %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
err()   { printf '\033[1;31m[error]\033[0m %s\n' "$*"; exit 1; }

# --- Detection ---

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

# --- Paths ---

# Resolve the dotfiles repo root from a module's scripts/install.sh.
# Usage (from inside a module install script):
#     DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"
dotfiles_root_from_module() {
    local script_dir="$1"
    (cd "$script_dir/../.." && pwd)
}

# --- Common installs ---

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

# Stow a single module from the dotfiles repo into $HOME.
# Usage: stow_module <module_name> <dotfiles_dir>
#
# Behaviour is controlled by the (optional) STOW_ADOPT / STOW_REPLACE env vars,
# normally set by the top-level install.sh based on --adopt / --replace flags.
#
# --replace: adopt existing files into the repo, then `git checkout` to discard
#            them, effectively replacing on-disk files with the repo versions.
#            Refuses to run if the module has uncommitted changes (would
#            otherwise destroy local work).
stow_module() {
    local name="$1"
    local dotfiles_dir="$2"

    if ! command_exists stow; then
        err "stow is not installed. Run the top-level install.sh first, or install stow manually."
    fi

    info "Stowing $name config..."
    if [ -n "${STOW_REPLACE:-}" ]; then
        # Safety check: refuse to --replace if the module has uncommitted changes,
        # because the `git checkout` step would silently discard them.
        if ! git -C "$dotfiles_dir" diff --quiet -- "$name" 2>/dev/null \
            || ! git -C "$dotfiles_dir" diff --cached --quiet -- "$name" 2>/dev/null; then
            err "$name has uncommitted changes; refusing to --replace (would discard local work). Commit or stash first."
        fi
        stow --no-folding -d "$dotfiles_dir" -t "$HOME" --adopt "$name"
        git -C "$dotfiles_dir" checkout -- "$name"
    else
        # ${STOW_ADOPT:-} is either empty or "--adopt"; word-splitting an empty
        # string yields no args, so this is safe without the :+ trick.
        # shellcheck disable=SC2086
        stow --no-folding ${STOW_ADOPT:-} -d "$dotfiles_dir" -t "$HOME" "$name"
    fi
    ok "$name config stowed"
}

ensure_brew() {
    if ! command_exists brew; then
        err "Homebrew is required on macOS. Install it from https://brew.sh"
    fi
}

pkg_install() {
    local pkg_manager
    pkg_manager="$(detect_linux_pkg_manager)"
    case "$pkg_manager" in
        pacman) sudo pacman -S --needed --noconfirm "$@" ;;
        apt)
            sudo apt-get update
            sudo apt-get install -y "$@"
            ;;
        dnf)    sudo dnf install -y "$@" ;;
        zypper) sudo zypper install -y "$@" ;;
    esac
}

install_package() {
    local binary="$1"
    shift
    local brew_args=()
    local pkg_name="$binary"

    while [ $# -gt 0 ]; do
        case "$1" in
            --cask) brew_args+=("--cask") ;;
            *)      pkg_name="$1" ;;
        esac
        shift
    done

    if command_exists "$binary"; then
        local ver
        ver=$("$binary" --version 2>/dev/null | head -1) || ver=""
        ok "$binary is already installed${ver:+ ($ver)}"
        return
    fi

    info "Installing $binary..."

    if [ "$(detect_os)" = "mac" ]; then
        ensure_brew
        brew install "${brew_args[@]}" "$pkg_name"
    else
        pkg_install "$pkg_name"
    fi

    if command_exists "$binary"; then
        local ver
        ver=$("$binary" --version 2>/dev/null | head -1) || ver=""
        ok "$binary installed${ver:+ ($ver)}"
    else
        err "$binary installation failed"
    fi
}
