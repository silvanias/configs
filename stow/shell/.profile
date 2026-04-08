if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if [ -d "/usr/local/texlive/2024/bin/universal-darwin" ]; then
  PATH="$PATH:/usr/local/texlive/2024/bin/universal-darwin"
fi

export PATH
