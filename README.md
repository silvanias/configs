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

From this repo root:

```bash
bash ./bootstrap-macos.sh
```

The script will:

1. Ensure `brew`, `stow`, and `starship` are available.
2. Back up conflicting files to `~/.dotfiles-backup/<timestamp>/`.
3. Stow shell and tmux dotfiles into `$HOME`.
4. Symlink Neovim and Starship config from this repo into `~/.config`.

After bootstrap, reload shell:

```bash
exec zsh
```

## Notes

- Neovim uses `~/.config/nvim` (symlinked to this repo).
- Prompt uses Starship config at `~/.config/starship.toml`.
- Icons in prompt require a Nerd Font in your terminal profile.
