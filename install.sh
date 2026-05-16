#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/helpers.sh
source "$SCRIPT_DIR/scripts/helpers.sh"

export STOW_ADOPT=""
export STOW_REPLACE=""

usage() {
    cat <<EOF
Usage: $(basename "$0") [--adopt | --replace]

Options:
  --adopt    Adopt existing files into the dotfiles repo (useful on machines
             that already have config files in place). WARNING: this will
             overwrite files in the repo with the existing versions.
  --replace  Remove existing configs and replace them with dotfiles versions.
             WARNING: requires a clean working tree per affected module;
             refuses to run if any module has uncommitted changes.
EOF
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

    # Install stow once up-front so module scripts can assume it's present.
    install_stow

    run_module ghostty
    run_module fish
    run_module starship
    run_module nvim
    run_module tmux
    run_module yazi
    run_module aerospace
    run_module hyprland

    echo
    ok "========================================"
    ok " All done! Restart your terminal to"
    ok " pick up all changes."
    ok "========================================"
}

main "$@"
