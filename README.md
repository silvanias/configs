# macOS Dotfiles

Personal macOS-focused dotfiles with Linux-inspired ergonomics.

## What this repo manages

- Shell startup files via GNU Stow:
  - `stow/shell/.zshrc`
  - `stow/shell/.zprofile`
  - `stow/shell/.zshenv`
  - `stow/shell/.profile`
  - `stow/shell/.bash_profile`
- tmux config via GNU Stow:
  - `stow/tmux/.tmux.conf`
- XDG app configs via direct symlink:
  - `.config/nvim`
  - `.config/starship.toml`

## Bootstrap on macOS

The script will:

1. Ensure `brew`, `stow`, and `starship` are available.
2. Install declared packages from `Brewfile` using `brew bundle`.
3. Back up conflicting files to `~/.dotfiles-backup/<timestamp>/`.
4. Stow shell and tmux dotfiles into `$HOME`.
5. Symlink Neovim and Starship config from this repo into `~/.config`.

## Track installed packages

This repo includes a `Brewfile` so machine setup is reproducible.

- Install all declared packages:

```bash
brew bundle --file Brewfile
```

- Refresh `Brewfile` from your current machine state:

```bash
brew bundle dump --force --file Brewfile
```

Use the dump command only when you want to intentionally update package inventory.

From this repo root:

```bash
bash ./bootstrap-macos.sh
```

After bootstrap, reload shell:

```bash
exec zsh
```

## Notes

- Neovim uses `~/.config/nvim` (symlinked to this repo).
- Prompt uses Starship config at `~/.config/starship.toml`.
- Icons in prompt require a Nerd Font in your terminal profile.
