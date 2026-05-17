#!/usr/bin/env bash
# Set the Hyprland wallpaper live without restarting hyprpaper.
#
# Usage:
#   wallpaper.sh                            # pick from ~/.config/backgrounds via wofi
#   wallpaper.sh /path/to/image.jpg         # use a specific file
#   wallpaper.sh https://example.com/x.jpg  # download a URL into ~/.config/backgrounds
#
# Live-applies the choice via Hyprland 0.55's hyprpaper IPC. A `wallpaper`
# symlink in ~/.config/backgrounds/ is updated so hyprlock and the next
# Hyprland start pick up the same image.

set -euo pipefail

BG_DIR="$HOME/.config/backgrounds"
DEFAULT_LINK="$BG_DIR/wallpaper"
mkdir -p "$BG_DIR"

die() { printf 'wallpaper.sh: %s\n' "$*" >&2; exit 1; }

pick_with_wofi() {
    if ! command -v wofi >/dev/null; then
        die "wofi not installed — pass a file path instead"
    fi
    local selection
    selection=$(find "$BG_DIR" -maxdepth 2 -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
        -not -name 'wallpaper' \
        -printf '%f\n' 2>/dev/null \
        | sort -u \
        | wofi --show dmenu --prompt 'Wallpaper:' --width 480 --height 400)
    [ -z "$selection" ] && exit 0
    echo "$BG_DIR/$selection"
}

resolve_input() {
    local arg="${1:-}"

    if [ -z "$arg" ]; then
        pick_with_wofi
        return
    fi

    case "$arg" in
        http://*|https://*)
            command -v curl >/dev/null || die "curl required to fetch URLs"
            local fname
            fname=$(basename "${arg%%\?*}")
            [ -z "$fname" ] && fname="downloaded-$(date +%s).img"
            local dest="$BG_DIR/$fname"
            curl -fsSL --max-time 60 -o "$dest" "$arg" \
                || die "download failed: $arg"
            echo "$dest"
            ;;
        *)
            [ -f "$arg" ] || die "no such file: $arg"
            # Canonicalise so hyprpaper gets an absolute path.
            readlink -f -- "$arg"
            ;;
    esac
}

apply() {
    local src="$1"

    # Update the canonical link that hyprlock + next-boot read.
    ln -sfn -- "$src" "$DEFAULT_LINK"

    if pgrep -x hyprpaper >/dev/null && command -v hyprctl >/dev/null; then
        # Hyprland 0.55+ hyprpaper IPC: only `wallpaper` is supported.
        # Hyprpaper auto-preloads paths it hasn't seen.
        hyprctl hyprpaper wallpaper ",$src" >/dev/null \
            || die "hyprctl hyprpaper failed"
    else
        echo "hyprpaper not running — will apply on next Hyprland start." >&2
    fi
}

src=$(resolve_input "${1:-}")
apply "$src"
echo "Wallpaper: $src"
