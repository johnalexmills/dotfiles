#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

install_herdr() {
  if command_exists herdr; then
    ok "herdr is already installed ($(herdr --version 2>/dev/null | head -1))"
    return
  fi

  info "Installing herdr..."
  if [ "$(detect_os)" = "mac" ]; then
    ensure_brew
    brew install herdr
  else
    if ! command_exists curl; then
      err "curl is required to install herdr"
    fi
    curl -fsSL https://herdr.dev/install.sh | sh
  fi

  if command_exists herdr; then
    ok "herdr installed ($(herdr --version 2>/dev/null | head -1))"
  else
    err "herdr installation failed or its install directory is not on PATH"
  fi
}

main() {
  info "Setting up herdr..."
  echo

  install_herdr
  stow_module "herdr" "$DOTFILES_DIR"

  echo
  ok "herdr setup complete!"
  info "Launch or attach with: herdr"
}

main
