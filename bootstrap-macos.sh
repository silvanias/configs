#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

log() { printf "%s\n" "$*"; }

ensure_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    log "Homebrew is required. Install from https://brew.sh and rerun."
    exit 1
  fi
}

ensure_pkg() {
  local pkg="$1"
  if ! command -v "$pkg" >/dev/null 2>&1; then
    brew install "$pkg"
  fi
}

backup_path() {
  local path="$1"
  if [[ -e "$path" && ! -L "$path" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$path" "$BACKUP_DIR/"
    log "Backed up $path -> $BACKUP_DIR/"
  fi
}

safe_link() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -L "$dst" || -e "$dst" ]]; then
    rm -rf "$dst"
  fi
  ln -s "$src" "$dst"
  log "Linked $dst -> $src"
}

main() {
  ensure_brew
  ensure_pkg stow
  ensure_pkg starship

  backup_path "$HOME/.zshrc"
  backup_path "$HOME/.zprofile"
  backup_path "$HOME/.zshenv"
  backup_path "$HOME/.profile"
  backup_path "$HOME/.bash_profile"
  backup_path "$HOME/.tmux.conf"
  backup_path "$HOME/.config/nvim"
  backup_path "$HOME/.config/starship.toml"

  stow -d "$REPO_DIR/stow" -t "$HOME" shell
  stow -d "$REPO_DIR/stow" -t "$HOME" tmux

  safe_link "$REPO_DIR/.config/nvim" "$HOME/.config/nvim"
  safe_link "$REPO_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

  log ""
  log "Bootstrap complete."
  log "Open a new terminal session or run: exec zsh"
}

main "$@"
