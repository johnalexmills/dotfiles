#!/usr/bin/env bash
set -euo pipefail

# --- Helpers ---

info()  { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
ok()    { printf '\033[1;32m[ok]\033[0m    %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
err()   { printf '\033[1;31m[error]\033[0m %s\n' "$*"; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export STOW_ADOPT=""
export STOW_REPLACE=""

usage() {
    echo "Usage: $(basename "$0") [--adopt | --replace]"
    echo
    echo "Options:"
    echo "  --adopt    Adopt existing files into the dotfiles repo (useful on machines"
    echo "             that already have config files in place). WARNING: this will"
    echo "             overwrite files in the repo with the existing versions."
    echo "  --replace  Remove existing configs and replace them with dotfiles versions."
    echo "             WARNING: any existing config files will be deleted."
}

# --- Parse arguments ---

parse_args() {
    while [ $# -gt 0 ]; do
        case "$1" in
            --adopt)
                if [ -n "$STOW_REPLACE" ]; then
                    err "--adopt and --replace are mutually exclusive"
                fi
                STOW_ADOPT="--adopt"
                warn "Running with --adopt: existing files will be pulled into the repo"
                ;;
            --replace)
                if [ -n "$STOW_ADOPT" ]; then
                    err "--adopt and --replace are mutually exclusive"
                fi
                STOW_REPLACE="1"
                warn "Running with --replace: existing config files will be deleted and replaced"
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                err "Unknown option: $1 (see --help)"
                ;;
        esac
        shift
    done
}

# --- Run a module's install script ---

run_module() {
    local name="$1"
    local script="$SCRIPT_DIR/$name/scripts/install.sh"

    if [ ! -f "$script" ]; then
        warn "No install script found for $name, skipping"
        return
    fi

    echo
    info "========================================"
    info " Setting up $name"
    info "========================================"
    echo

    bash "$script"
}

# --- Main ---

main() {
    parse_args "$@"

    info "========================================"
    info " dotfiles — full system setup"
    info "========================================"

    run_module ghostty
    run_module fish
    run_module starship
    run_module nvim
    run_module tmux
    run_module yazi

    echo
    ok "========================================"
    ok " All done! Restart your terminal to"
    ok " pick up all changes."
    ok "========================================"
}

main "$@"
