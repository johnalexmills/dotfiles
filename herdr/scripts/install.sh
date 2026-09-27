#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

DOTFILES_DIR="$(dotfiles_root_from_module "$SCRIPT_DIR")"

herdr_version() {
  local bin
  if command_exists herdr; then
    bin="herdr"
  elif [ -x "$HOME/.local/bin/herdr" ]; then
    bin="$HOME/.local/bin/herdr"
  else
    return 1
  fi
  "$bin" --version 2>/dev/null | head -1
}

install_herdr() {
  # The upstream installer drops the binary in ~/.local/bin, which is not on
  # PATH by default on Arch. Reconcile PATH first so the checks below reflect
  # reality instead of reporting a successful install as a failure.
  ensure_user_bin_on_path

  if command_exists herdr; then
    ok "herdr is already installed ($(herdr_version))"
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

  # Re-check PATH: the installer may have just created ~/.local/bin.
  ensure_user_bin_on_path

  if command_exists herdr; then
    ok "herdr installed ($(herdr_version))"
  elif bin="$(resolve_binary herdr)"; then
    # Installed, but the shell still cannot run it. Name the directory the
    # binary actually landed in rather than assuming ~/.local/bin.
    warn "herdr installed to $bin, but that directory is not on PATH"
    info "Add it to your shell config:"
    info "  fish_add_path \"$(dirname "$bin")\""
  else
    err "herdr installation failed"
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
