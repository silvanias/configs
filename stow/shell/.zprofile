typeset -U path PATH

# Homebrew first; many language/toolchain bins depend on this ordering.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Toolchains that should exist for login shells.
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

if [[ -d "/usr/local/texlive/2024/bin/universal-darwin" ]]; then
  path+=("/usr/local/texlive/2024/bin/universal-darwin")
fi

export PATH

# pipx user-installed binaries
if [[ -d "$HOME/.local/bin" ]]; then
  path+=("$HOME/.local/bin")
fi
export PATH
