#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/helpers.sh
source "$SCRIPT_DIR/scripts/helpers.sh"

export STOW_ADOPT=""
export STOW_REPLACE=""
DRY_RUN=""
SELECTED_MODULES=""
# Modules whose install script exited non-zero. Populated by run_module.
FAILED_MODULES=()
# Install order. Also the list --modules is validated against.
MODULES=(ghostty fish starship nvim herdr yazi aerospace)

usage() {
  cat <<EOF
Usage: $(basename "$0") [--adopt | --replace] [--dry-run] [--modules m1,m2,...]

Options:
  --adopt    Adopt existing files into the dotfiles repo (useful on machines
             that already have config files in place). WARNING: this will
             overwrite files in the repo with the existing versions.
  --replace  Remove existing configs and replace them with dotfiles versions.
             WARNING: requires a clean working tree per affected module;
             refuses to run if any module has uncommitted changes.
  --dry-run  Show what would be done without making changes.
  --modules  Comma-separated list of modules to install (default: all).
             Available: ${MODULES[*]}
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
      --dry-run)
        DRY_RUN="1"
        info "Dry run: no changes will be made"
        ;;
      --modules)
        shift
        if [ $# -eq 0 ] || [[ "$1" == --* ]]; then
          err "--modules requires a comma-separated list of module names"
        fi
        SELECTED_MODULES="$1"
        validate_modules "$SELECTED_MODULES"
        ;;
      -h | --help)
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

# Reject unknown names up-front; otherwise a typo like --modules nvm silently
# installs nothing and still reports "All done!".
validate_modules() {
  local IFS=','
  local mod known
  for mod in $1; do
    for known in "${MODULES[@]}"; do
      [ "$mod" = "$known" ] && continue 2
    done
    err "Unknown module: $mod (available: ${MODULES[*]})"
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

  # If --modules was specified, skip modules not in the list
  if [ -n "$SELECTED_MODULES" ]; then
    local IFS=','
    local found=0 mod
    for mod in $SELECTED_MODULES; do
      if [ "$mod" = "$name" ]; then
        found=1
        break
      fi
    done
    if [ "$found" -eq 0 ]; then
      return
    fi
  fi

  echo
  info "========================================"
  info " Setting up $name"
  info "========================================"
  echo

  if [ "$DRY_RUN" = "1" ]; then
    info "[dry-run] Would run: $script"
    return
  fi

  # A module failing must not abort the remaining modules. Without this,
  # `set -e` in main() would kill the whole run on the first non-zero exit,
  # silently skipping every module queued behind it. Failures are recorded
  # in FAILED_MODULES and reported in the summary.
  if ! bash "$script"; then
    warn "$name setup failed (see error above)"
    FAILED_MODULES+=("$name")
  fi
}

# --- Main ---

main() {
  parse_args "$@"

  info "========================================"
  info " dotfiles — full system setup"
  info "========================================"

  if [ "$DRY_RUN" != "1" ]; then
    # Install stow once up-front so module scripts can assume it's present.
    install_stow

    # Enable pre-commit hooks
    info "Configuring git hooks..."
    git -C "$SCRIPT_DIR" config core.hooksPath .githooks
    ok "Git hooks configured (.githooks/pre-commit)"
  fi

  local mod
  for mod in "${MODULES[@]}"; do
    run_module "$mod"
  done

  echo
  if [ ${#FAILED_MODULES[@]} -gt 0 ]; then
    # err() exits on its first call, so the summary is emitted as a single
    # multi-line message. A non-zero exit keeps CI honest about the partial
    # failure even though every module was attempted.
    err "========================================
 ${#FAILED_MODULES[@]} module(s) failed: ${FAILED_MODULES[*]}
 Fix the above, then re-run just those, e.g.:
   ./install.sh --modules ${FAILED_MODULES[0]}
========================================"
  fi

  ok "========================================"
  ok " All done! Restart your terminal to"
  ok " pick up all changes."
  ok "========================================"
}

main "$@"
