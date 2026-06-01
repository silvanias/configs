export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)

if [[ -s "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS SHARE_HISTORY HIST_REDUCE_BLANKS

bindkey -e
setopt AUTO_CD INTERACTIVE_COMMENTS

alias vi="nvim"
alias vim="nvim"
alias v="nvim"
alias ..="cd .."
alias t="tree"
alias top="btop"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias update="brew update && brew upgrade && brew cleanup"

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --group-directories-first"
  alias ll="eza -lah --git --group-directories-first"
  alias la="eza -a --group-directories-first"
fi

if command -v fastfetch >/dev/null 2>&1 && [[ -z "$TMUX" ]]; then
  fastfetch
fi

# >>> conda initialize >>>
if [[ -x "$HOME/anaconda3/bin/conda" ]]; then
  __conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
  if [[ $? -eq 0 ]]; then
    eval "$__conda_setup"
  elif [[ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
    source "$HOME/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="$HOME/anaconda3/bin:$PATH"
  fi
  unset __conda_setup
fi
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# tmux (attach default session or create "main")
if command -v tmux >/dev/null 2>&1; then
  alias ta='tmux attach -t main 2>/dev/null || tmux new -s main'
  alias tl='tmux list-sessions'
  alias ts='tmux new-session -s'
fi

export STARSHIP_CONFIG="$HOME/.config/starship.toml"
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

export HOMEBREW_NO_ENV_HINTS=1
# $HOME/.local/bin is added in .zprofile (pipx)
