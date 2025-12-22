typeset -g POWERLEVEL10K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

ZSH_DISABLE_COMPFIX=true
[[ $- != *i* ]] && return
export TERM="xterm-256color"
export COLORTERM="truecolor"
export LANG=pt_BR.UTF-8
export PATH="${HOME}/bin:${HOME}/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export BROWSER="firefox"
export TERMINAL="ptyxis"
export ARCHFLAGS="-arch $(uname -m)"
export MOZ_ENABLE_WAYLAND=1
export MESA_LOADER_DRIVER_OVERRIDE=crocus
export MESA_VK_IGNORE_ENV=1

plugins=(
  git
  sudo
  command-not-found
  colored-man-pages
  history-substring-search
)

autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

source $ZSH/oh-my-zsh.sh

if [ -f "$HOME/.zsh_aliases" ]; then
  source "$HOME/.zsh_aliases"
fi

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='gedit'
fi

if command -v eza >/dev/null 2>&1 && ! alias eza &>/dev/null; then
  alias dir='eza -l --group-directories-first --icons --color=auto'
  alias l='eza --classify --icons --color=auto'
  alias la='eza -A --classify --icons --color=auto'
  alias ll='eza -al --group-directories-first --icons --color=auto'
  alias lla='eza -al --group-directories-first --icons --color=auto'
  alias ls='eza --icons --color=auto'
else
  alias dir='ls -l --color=auto'
  alias l='ls -CF --color=auto'
  alias la='ls -A --color=auto'
  alias ll='ls -alF --color=auto'
  alias lla='ls -al --color=auto'
  alias ls='ls --color=auto'
fi

HISTFILE=$HOME/.zsh_history
HISTSIZE=102400
SAVEHIST=$HISTSIZE
HIST_STAMPS="dd.mm.yyyy"
setopt hist_ignore_dups share_history
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt NO_NOMATCH
setopt correct
setopt autocd
setopt extended_glob
unsetopt beep

if [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
elif [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

if [[ -r /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh
elif [[ -r /usr/share/doc/fzf/examples/completion.zsh ]]; then
  source /usr/share/doc/fzf/examples/completion.zsh
fi

if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

bindkey '^[ [ A' history-substring-search-up
bindkey '^[ [ B' history-substring-search-down
bindkey '^[ [ C' forward-char
bindkey '^[ [ D' backward-char
bindkey '^F' autosuggest-accept
bindkey '^E' autosuggest-execute
bindkey '^U' autosuggest-clear

if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

sysdaemon() { sudo systemctl daemon-reexec; }
sysedit() { sudo systemctl edit "$@"; }
sysreload() { sudo systemctl reload "$@"; }
sysrestart() { sudo systemctl restart "$@"; }
sysstart() { sudo systemctl start "$@"; }
sysstop() { sudo systemctl stop "$@"; }

extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2)  tar xjf "$1" ;;
      *.tar.gz)   tar xzf "$1" ;;
      *.bz2)      bunzip2 "$1" ;;
      *.rar)      unrar x "$1" ;;
      *.gz)       gunzip "$1" ;;
      *.tar)      tar xf "$1" ;;
      *.tbz2)     tar xjf "$1" ;;
      *.tgz)      tar xzf "$1" ;;
      *.zip)      unzip "$1" ;;
      *.Z)        uncompress "$1" ;;
      *.7z)       7z x "$1" ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' Invalid File"
  fi
}

