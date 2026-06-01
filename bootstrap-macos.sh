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

ensure_omz() {
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

ensure_omz_plugin() {
  local name="$1"
  local repo="$2"
  local dest="$HOME/.oh-my-zsh/custom/plugins/$name"
  if [[ ! -d "$dest" ]]; then
    log "Installing OMZ plugin: $name"
    git clone --depth=1 "$repo" "$dest"
  fi
}

main() {
  ensure_brew
  ensure_pkg stow
  ensure_pkg starship

  if [[ -f "$REPO_DIR/Brewfile" ]]; then
    log "Installing packages from Brewfile..."
    if ! brew bundle --file "$REPO_DIR/Brewfile"; then
      log "Warning: 'brew bundle' had errors. Common causes:"
      log "  - VS Code CLI ('code') not installed → vscode \"...\" lines fail"
      log "  - A tap/cask requires manual approval on first install"
      log "Continuing; rerun 'brew bundle --file Brewfile' after resolving."
    fi
  fi

  ensure_omz
  ensure_omz_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
  ensure_omz_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"

  backup_path "$HOME/.zshrc"
  backup_path "$HOME/.zprofile"
  backup_path "$HOME/.zshenv"
  backup_path "$HOME/.profile"
  backup_path "$HOME/.bash_profile"
  backup_path "$HOME/.tmux.conf"
  backup_path "$HOME/.config/nvim"
  backup_path "$HOME/.config/starship.toml"
  backup_path "$HOME/.config/ghostty/config"

  stow -d "$REPO_DIR/stow" -t "$HOME" shell
  stow -d "$REPO_DIR/stow" -t "$HOME" tmux

  TPM_DIR="$HOME/.tmux/plugins/tpm"
  if [[ ! -d "$TPM_DIR" ]]; then
    log "Installing TPM (tmux plugin manager)..."
    mkdir -p "$HOME/.tmux/plugins"
    git clone https://github.com/tmux-plugins/tpm.git "$TPM_DIR"
  fi

  safe_link "$REPO_DIR/.config/nvim" "$HOME/.config/nvim"
  safe_link "$REPO_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
  safe_link "$REPO_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"

  log ""
  log "Bootstrap complete (minimal core installed)."
  log "Open a new terminal session or run: exec zsh"
  log ""
  log "tmux: run 'ta', then Ctrl-a+I to install plugins. See COMMANDS.md for keybinds."
  log "Optional heavy packages: brew bundle --file \"$REPO_DIR/Brewfile.extras\""
}

main "$@"
