#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

# --- Linux only ---

if [ "$(detect_os)" != "linux" ]; then
    warn "Hyprland is Linux only — skipping"
    exit 0
fi

# --- Install packages ---

install_packages() {
    info "Installing hyprland and dependencies..."

    local pkgs=(
        hyprland hyprlock hypridle hyprpaper hyprshot hyprpolkitagent
        xdg-desktop-portal-hyprland
        waybar wofi swaync ghostty
        brightnessctl pamixer pavucontrol
        wl-clipboard cliphist grim slurp
        ttf-jetbrains-mono-nerd noto-fonts-emoji
        qt5-wayland qt6-wayland qt5ct qt6-declarative qt6-svg
        thunar
        # Thumbnailers — tumbler is the daemon thunar uses; plugins extend it
        # to videos / webp / PDFs.
        tumbler ffmpegthumbnailer webp-pixbuf-loader poppler-glib
        pipewire pipewire-pulse wireplumber
        sddm
        gamescope gamemode mangohud
        imagemagick
    )

    local pkg
    pkg="$(detect_linux_pkg_manager)"

    case "$pkg" in
        pacman)
            sudo pacman -S --needed --noconfirm "${pkgs[@]}"
            ;;
        apt)
            sudo apt-get update
            sudo apt-get install -y "${pkgs[@]}"
            ;;
        dnf)
            sudo dnf install -y "${pkgs[@]}"
            ;;
        zypper)
            sudo zypper install -y "${pkgs[@]}"
            ;;
    esac

    ok "Packages installed"
}

# --- Install AUR packages ---

install_aur() {
    local aur_pkgs=(
        catppuccin-cursors-mocha
        catppuccin-gtk-theme-mocha
    )
    local missing=()

    for pkg in "${aur_pkgs[@]}"; do
        if paru -Q "$pkg" &>/dev/null 2>&1; then
            ok "$pkg is already installed"
        else
            missing+=("$pkg")
        fi
    done

    if [ ${#missing[@]} -eq 0 ]; then
        return
    fi

    if command_exists paru; then
        paru -S --noconfirm "${missing[@]}"
    elif command_exists yay; then
        yay -S --noconfirm "${missing[@]}"
    else
        warn "Install AUR packages manually: paru -S ${missing[*]}"
    fi
}

# --- Enable SDDM ---

setup_sddm() {
    if systemctl is-enabled gdm &>/dev/null 2>&1; then
        info "Disabling GDM (will take effect on next boot)..."
        sudo systemctl disable gdm
        ok "GDM disabled"
    fi

    if systemctl is-enabled sddm &>/dev/null 2>&1; then
        ok "SDDM is already enabled"
    else
        info "Enabling SDDM (will start on next boot)..."
        sudo systemctl enable sddm
        ok "SDDM enabled"
    fi
}

# --- Install Catppuccin SDDM theme ---

install_sddm_theme() {
    local theme_name="catppuccin-mocha-mauve"
    local theme_dir="/usr/share/sddm/themes/$theme_name"

    if [ -d "$theme_dir" ]; then
        ok "Catppuccin SDDM theme already installed"
        configure_sddm_theme "$theme_name"
        return
    fi

    info "Installing Catppuccin SDDM theme from AUR..."

    if command_exists paru; then
        paru -S --noconfirm catppuccin-sddm-theme-mocha
    elif command_exists yay; then
        yay -S --noconfirm catppuccin-sddm-theme-mocha
    else
        warn "No AUR helper found (yay/paru). Installing SDDM theme manually..."
        install_sddm_theme_manual
    fi

    if [ -d "$theme_dir" ]; then
        configure_sddm_theme "$theme_name"
    else
        warn "SDDM theme directory not found after install — skipping config"
        warn "Fix later: sudo paru -S catppuccin-sddm-theme-mocha"
    fi
}

install_sddm_theme_manual() {
    local tmpdir
    tmpdir="$(mktemp -d)"
    local release_url="https://github.com/catppuccin/sddm/releases/download/v1.1.2/catppuccin-mocha-mauve-sddm.zip"

    info "Downloading theme from $release_url ..."
    curl -fsSL -o "$tmpdir/theme.zip" "$release_url" || {
        warn "Failed to download SDDM theme"
        rm -rf "$tmpdir"
        return
    }

    sudo mkdir -p /usr/share/sddm/themes
    sudo unzip -q "$tmpdir/theme.zip" -d /usr/share/sddm/themes/ 2>/dev/null
    rm -rf "$tmpdir"
    ok "SDDM theme downloaded"
}

configure_sddm_theme() {
    local theme_name="$1"

    if grep -q "Current=$theme_name" /etc/sddm.conf 2>/dev/null; then
        ok "SDDM theme already configured"
        return
    fi

    info "Configuring /etc/sddm.conf to use $theme_name..."
    echo "[Theme]
Current=$theme_name" | sudo tee /etc/sddm.conf > /dev/null
    ok "SDDM theme configured"
}

# --- Download a default wallpaper ---

install_wallpaper() {
    local bg_dir="$HOME/.config/backgrounds"
    local wallpaper="$bg_dir/wallpaper"
    mkdir -p "$bg_dir"

    if [ -f "$wallpaper" ]; then
        ok "Wallpaper already exists at $wallpaper"
        return
    fi

    # Default: orangc's catppuccin-mocha "dark-star" — pairs with the mauve accent.
    # Browse alternatives at https://orangc.net/wallsppuccin/ and swap with
    # `~/.config/hypr/wallpaper.sh <path-or-url>` or Super+Shift+W.
    info "Downloading default Catppuccin wallpaper (dark-star)..."
    curl -fsSL -o "$wallpaper" \
        "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/master/dark-star.jpg" || {
        warn "Failed to download wallpaper — place one manually at $wallpaper"
    }
}

# --- Create .face placeholder ---

install_face() {
    if [ -f "$HOME/.face" ]; then
        ok ".face already exists"
        return
    fi
    info "Creating placeholder ~/.face (avatar for lock screen)..."
    # ImageMagick 7 uses `magick`; 6 uses `convert`. Either way we have to
    # prefix the output with `png:` because ~/.face has no extension, and
    # without a hint magick would try to use the source format (XC) which
    # is not encodable.
    if command_exists magick; then
        magick -size 100x100 xc:'#cba6f7' "png:$HOME/.face"
    elif command_exists convert; then
        convert -size 100x100 xc:'#cba6f7' "png:$HOME/.face"
    else
        warn "imagemagick not found — place a 100x100 image at ~/.face for the lock screen avatar"
        return
    fi
    ok ".face placeholder created"
}

# --- Main ---

enable_polkit_agent() {
    if systemctl --user is-enabled hyprpolkitagent.service &>/dev/null; then
        ok "hyprpolkitagent user service already enabled"
        return
    fi
    info "Enabling hyprpolkitagent user service..."
    systemctl --user enable hyprpolkitagent.service || \
        warn "Could not enable hyprpolkitagent.service (will still start via exec-once on Hyprland launch)"
}

main() {
    info "Setting up Hyprland..."
    echo

    install_stow
    install_packages
    install_aur
    install_sddm_theme
    setup_sddm
    install_wallpaper
    install_face
    enable_polkit_agent

    stow_module hyprland "$DOTFILES_DIR"

    echo
    ok "Hyprland setup complete!"
    info "Reboot to see SDDM login with Catppuccin Mocha theme"
    info "Keybinds: Alt+Space (launcher), Super+Return (terminal),"
    info "          Super+Shift+L (lock), Super+Shift+W (wallpaper picker)"
    info "Gaming: use 'gamescope -f -- <command>' for per-game FSR/VRR"
}

main
