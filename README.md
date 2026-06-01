# macOS Dotfiles

Personal macOS-focused dotfiles with Linux-inspired ergonomics.

**Shortcuts & how to apply:** see [COMMANDS.md](./COMMANDS.md).

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
  - `.config/ghostty/config`

## Prerequisites (fresh Mac)

1. **Xcode Command Line Tools** (provides `git`):

   ```bash
   xcode-select --install
   ```

2. **Homebrew** ([brew.sh](https://brew.sh)):

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. (Optional) Install **Cursor** or **VS Code** *before* running bootstrap if you want the `vscode "..."` Brewfile entries to install successfully. Without one of them, the bundle step warns and continues — you can rerun later.

## Bootstrap

```bash
git clone https://github.com/silvanias/configs.git ~/CodingProjects/configs
cd ~/CodingProjects/configs
bash ./bootstrap-macos.sh
exec zsh
```

The script will:

1. Verify `brew` is installed; install `stow` and `starship` if missing.
2. Install the **minimal core** from `Brewfile` via `brew bundle` (warns on failure, continues).
3. Install **Oh My Zsh** if missing.
4. Install the `zsh-autosuggestions` and `zsh-syntax-highlighting` OMZ plugins.
5. Back up any conflicting files in `$HOME` to `~/.dotfiles-backup/<timestamp>/`.
6. Stow shell + tmux dotfiles into `$HOME`.
7. Clone **TPM** (tmux plugin manager) into `~/.tmux/plugins/tpm`.
8. Symlink Neovim, Starship, and Ghostty configs into `~/.config`.

After bootstrap:

```bash
exec zsh
ta                  # start tmux session "main"
# inside tmux: press Ctrl-a then I  → installs TPM plugins
```

In **Cursor**, set the terminal font to a Nerd Font for prompt icons (see [COMMANDS.md](./COMMANDS.md#cursor-terminal-font-icons-in-starship)). **Ghostty** is configured automatically via `~/.config/ghostty/config`.

## Packages: minimal core + optional extras

Bootstrap installs only a **minimal core** so a fresh machine stays lean (version control, Neovim, tmux, Starship, a few shell utilities, build basics, Nerd Fonts).

| File | Contents | Installed by bootstrap |
|------|----------|------------------------|
| `Brewfile` | Minimal dev core (~16 formulae + fonts) | Yes |
| `Brewfile.extras` | Heavy/optional: LaTeX, ffmpeg, databases, language runtimes, GUI apps, VS Code extensions | No |

```bash
brew bundle --file Brewfile            # core (also run by bootstrap)
brew bundle --file Brewfile.extras     # opt into the heavy stuff

# Refresh a file from the current machine state (use deliberately):
brew bundle dump --force --file Brewfile
```

## tmux

Config lives at `stow/tmux/.tmux.conf` (stowed to `~/.tmux.conf`).

Inspired by [Dreams of Code's tmux setup](https://github.com/dreamsofcode-io/tmux), adapted for this repo:

- **Prefix:** `Ctrl-a` + key as a chord (e.g. `Ctrl-a` `\` to split) — see [COMMANDS.md](./COMMANDS.md)
- **Theme:** [egel/tmux-gruvbox](https://github.com/egel/tmux-gruvbox) (`dark256`) to match Starship's gruvbox palette
- **Plugins (TPM):** sensible, gruvbox, vim-tmux-navigator, yank

**Daily keys:** `Ctrl-a` `\` split · `Ctrl-a` `-` stack · `Ctrl-a` `x` close pane · `Alt` + arrows move panes — see [COMMANDS.md](./COMMANDS.md)

Neovim loads `vim-tmux-navigator` from `.config/nvim/lua/plugins/tmux.lua`.

## Notes

- Neovim uses `~/.config/nvim` (symlinked to this repo).
- Prompt uses Starship config at `~/.config/starship.toml`.
- Icons in prompt require a Nerd Font. **Ghostty** gets this from `~/.config/ghostty/config`; for iTerm/Cursor set the font manually.
- Ghostty config sets `macos-option-as-alt` so tmux `Alt`-key bindings (e.g. `Alt`+arrows) work.
- `fastfetch` is skipped when already inside tmux.
- The tmux `Ctrl-h/j/k/l` passthrough preserves zsh's emacs bindings (backspace / clear, etc.) while still letting Neovim navigate splits.
