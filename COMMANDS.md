# Commands & shortcuts

Reference for dotfiles in this repo. Prefix keys are written as `Ctrl-a` meaning hold Control and press `a`.

---

## Applying config

### Full setup (new machine or first time)

From the repo root:

```bash
cd ~/CodingProjects/configs   # or wherever you cloned this repo
bash ./bootstrap-macos.sh
exec zsh
```

Bootstrap will: install Brewfile packages, back up conflicting files, **stow** shell + tmux configs, clone **TPM**, and symlink Neovim + Starship.

### After you edit configs in this repo (quick apply)

```bash
cd ~/CodingProjects/configs

# Shell + tmux (symlinks into $HOME)
stow -d stow -t "$HOME" shell tmux

# Neovim + Starship (if you changed those)
ln -sf "$(pwd)/.config/nvim" "$HOME/.config/nvim"
ln -sf "$(pwd)/.config/starship.toml" "$HOME/.config/starship.toml"

exec zsh
```

### tmux plugins (one-time or after plugin changes)

```bash
ta                    # attach or create session "main"
# Inside tmux: Ctrl-a, then I   (capital I — installs TPM plugins)
# Reload tmux config: Ctrl-a, then r
```

If TPM is missing:

```bash
git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
ta
# then Ctrl-a, I
```

### Cursor terminal font (icons in Starship)

Set in **Cursor Settings → Terminal → Integrated: Font Family**:

`'JetBrainsMono NFM', 'JetBrainsMono Nerd Font Mono', monospace`

Reload the window or open a new terminal tab.

---

## Shell (zsh)

### Aliases

| Command | Does |
|---------|------|
| `v`, `vi`, `vim` | Open Neovim |
| `..` | `cd ..` |
| `t` | `tree` |
| `top` | `btop` |
| `l` | Short listing (`ls -CF`, or `eza` if installed) |
| `la` | List almost all (`ls -A` / `eza -a`) |
| `ll` | Long listing with details |
| `ls` | `eza --group-directories-first` when `eza` is installed |
| `update` | `brew update && brew upgrade && brew cleanup` |

### tmux aliases

| Command | Does |
|---------|------|
| `ta` | Attach to session `main`, or create it |
| `tl` | List tmux sessions |
| `ts NAME` | New session named `NAME` |

### Oh My Zsh plugins (no extra keys in this repo)

Enabled in `.zshrc`: `git`, `z`, `zsh-autosuggestions`, `zsh-syntax-highlighting`.

- **z**: `z configs` jumps to a frecent dir matching `configs`
- **Autosuggestions**: gray ghost text; `→` (right arrow) accepts suggestion
- **git plugin**: adds many `g*` aliases (e.g. `gst` = status); run `alias \| grep '^g'` to list

### Shell behavior

- **Emacs line editing** (`bindkey -e`): `Ctrl-a` beginning of line, `Ctrl-e` end, etc.
- **AUTO_CD**: type a directory path without `cd` to enter it
- **Starship** prompt from `~/.config/starship.toml` (gruvbox-style segments)
- **fastfetch** runs on shell start **only outside tmux**

---

## tmux

**Prefix:** `Ctrl-a`. Tmux always uses *prefix → command*; you can hold `Ctrl` the whole time or release it between keys ([why](https://superuser.com/questions/263940/how-can-i-keep-the-tmux-prefix-key-pressed-between-commands)).

**Literal `Ctrl-a` in shell** (start of line): press `Ctrl-a` **twice** quickly.

### Splits & panes

| Keys (release Ctrl) | Keys (hold Ctrl) | Action |
|---------------------|------------------|--------|
| `Ctrl-a` `\` or `v` | `Ctrl-a` `Ctrl-\` | Split **side by side** |
| `Ctrl-a` `-` or `s` | `Ctrl-a` `Ctrl-_` | Split **stacked** |
| `Ctrl-a` `c` | `Ctrl-a` `Ctrl-c` | New window |
| `Ctrl-a` `x` | `Ctrl-a` `Ctrl-x` | Close pane (asks to confirm) |
| `Ctrl-a` `z` | — | Zoom pane |
| `Ctrl-a` `d` | `Ctrl-a` `Ctrl-d` | Detach |
| `Ctrl-a` `h/j/k/l` | — | Focus pane left/down/up/right |
| `Ctrl-a` `H/J/K/L` | — | Resize pane (repeatable) |
| `Ctrl-a` `n` / `p` | `Ctrl-a` `Ctrl-n/p` | Next / previous window (repeatable) |
| `Ctrl-a` `w` | — | Pick window |
| `Ctrl-a` `r` | — | Reload config |

### No prefix

| Keys | Action |
|------|--------|
| `Alt` + arrows | Move between panes |
| `Shift` + `←` / `→` | Previous / next window |
| `Ctrl-l` | Clear screen (forwarded to zsh) |
| Right-click a pane | Built-in menu (splits, close, etc.) |

### Sessions & attaching

| Command / keys | Action |
|----------------|--------|
| `ta` | Attach `main` or create it |
| `tl` | List sessions |
| `ts NAME` | New session |

### Copy mode (vi)

| Keys | Action |
|------|--------|
| `Ctrl-a` `[` | Enter copy mode |
| `v` | Start selection |
| `y` | Yank to clipboard & exit |
| `q` | Quit copy mode |
| Mouse | Select text (mouse is on) |

### Config & plugins (TPM)

| Keys | Action |
|------|--------|
| `Ctrl-a` `r` | Reload `~/.tmux.conf` |
| `Ctrl-a` `I` | Install TPM plugins |
| `Ctrl-a` `U` | Update TPM plugins |
| `Ctrl-a` `?` | List all key bindings |

---

## Neovim ↔ tmux

**vim-tmux-navigator** (only inside Neovim — tmux’s side is disabled so zsh keeps emacs bindings `C-h` / `C-l`):

| Keys (in Neovim) | Action |
|------------------|--------|
| `Ctrl-h` | Left split / tmux pane |
| `Ctrl-j` | Down |
| `Ctrl-k` | Up |
| `Ctrl-l` | Right |

Outside Neovim use `Alt` + arrows for tmux panes. Arrow keys are disabled in Normal mode in Neovim; use `hjkl`.

---

## Neovim

**Leader:** `Space`

### File & search

| Keys | Action |
|------|--------|
| `Space` `e` | Open mini.files explorer |
| `Space` `ff` | Telescope: find files |
| `Space` `fg` | Telescope: live grep |
| `Space` `fb` | Telescope: buffers |
| `Space` `fh` | Telescope: help tags |
| `Space` `f` | Format buffer (conform.nvim) |
| `Space` `yf` | Yank relative file path to `+` register |

### Insert mode

| Keys | Action |
|------|--------|
| `j` `k` | Exit to Normal mode |

### Inside Telescope (default)

| Keys | Action |
|------|--------|
| `Ctrl-j` / `Ctrl-k` | Next / previous item |
| `Enter` | Open selection |
| `Esc` | Close |

### Useful built-ins

| Keys | Action |
|------|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `u` | Undo |
| `Ctrl-r` | Redo |
| `gg` / `G` | Top / bottom of file |

---

## Where configs live

| What | Repo path | On disk after apply |
|------|-----------|---------------------|
| zsh | `stow/shell/.zshrc` etc. | `~/.zshrc` → stow symlink |
| tmux | `stow/tmux/.tmux.conf` | `~/.tmux.conf` → stow symlink |
| Neovim | `.config/nvim/` | `~/.config/nvim` → repo symlink |
| Starship | `.config/starship.toml` | `~/.config/starship.toml` → repo symlink |
| tmux plugins | — | `~/.tmux/plugins/` (not in repo) |

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Changes not showing | `exec zsh`; for tmux run `Ctrl-a` `r` or restart session |
| Broken prompt icons | Nerd Font in terminal (see above) |
| tmux theme plain / no plugins | Inside tmux: `Ctrl-a` `I` |
| `stow` conflict | Remove or move the conflicting file in `$HOME`, then stow again |
| Nested tmux | Avoid running `ta` inside an existing tmux session unless intentional |
| `Ctrl-l` doesn’t clear / `Ctrl-h` doesn’t backspace in zsh | Reload tmux config (`Ctrl-a` `r`); the `C-h/j/k/l` passthrough must be set |
