if alias lsd &>/dev/null; then
  unalias lsd
fi
unset -f lsd 2>/dev/null

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
export LC_ALL=pt_BR.UTF-8
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export BROWSER="firefox"
export TERMINAL="gnome-terminal"
export ARCHFLAGS="-arch $(uname -m)"
export MOZ_ENABLE_WAYLAND=1

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

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='micro'
fi

alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias mkdir='mkdir -pv'

alias cpuinfo='lscpu'
alias free='free -h'
alias meminfo='cat /proc/meminfo'
alias df='df -h'

alias fdn='fd -HI --type f'
alias fna='find . -type f -iname'
alias fnd='find . -iname'

if command -v lsd >/dev/null 2>&1 && ! alias lsd &>/dev/null; then
  alias dir='lsd -l --group-dirs=first --icon=always --color=auto'
  alias l='lsd --classify --icon=always --color=auto'
  alias la='lsd -A --classify --icon=always --color=auto'
  alias ll='lsd -al --group-dirs=first --icon=always --color=auto'
  alias lla='lsd -al --group-dirs=first --icon=always --color=auto'
  alias ls='lsd --icon=always --color=auto'
  alias lsdonly='lsd -l --directory-only --icon=always --color=auto'
else
  alias dir='ls -l --color=auto'
  alias l='ls -CF --color=auto'
  alias la='ls -A --color=auto'
  alias ll='ls -alF --color=auto'
  alias lla='ls -al --color=auto'
  alias ls='ls --color=auto'
fi

alias top='htop'
alias hosts='sudo micro /etc/hosts'
alias ipa='ip -c a'
alias ipinfo='curl -s ipinfo.io'
alias myip="ip -4 addr show | grep -oP '(?<=inet\\s)\\d+(\\.\\d+){3}'"
alias pingg='ping archlinux.org'
alias ports='sudo ss -tulwn'
alias whichport="sudo ss -tulwn | grep LISTEN"
alias flushcache='sync && echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null'
alias flushdns='sudo resolvectl flush-caches'
alias iptableslist='sudo iptables -L -v -n'

alias cl-all='sudo paccache -ruk0'
alias cl-broken='sudo pacman -Dk && sudo pacman -Qk'
alias cl-cache='sudo paccache -rk1'
alias cl-orphs='orphs=$(pacman -Qtdq 2>/dev/null); [[ -n "$orphs" ]] && sudo pacman -Rns $orphs || echo "No orphaned packages found."'
alias dracut-zen='sudo dracut -f -H -v /boot/initramfs-linux-zen.img '
alias dracut-fall='sudo dracut -f -v /boot/initramfs-linux-zen-fallback.img'
alias updata='sudo pacman -Syyu'
alias update='sudo pacman -Syu'

alias sys='fastfetch'
alias sysactive='systemctl list-units --type=service --state=active'
alias sysdaemon='sudo systemctl daemon-reexec'
alias sysdisabled='systemctl list-unit-files --state=disabled'
alias sysedit='sudo systemctl edit'
alias sysenabled='systemctl list-unit-files --state=enabled'
alias syslist='systemctl list-units --type=service'
alias sysreload='sudo systemctl reload'
alias sysrestart='sudo systemctl restart'
alias sysstart='sudo systemctl start'
alias sysstatus='systemctl --failed'
alias sysstop='sudo systemctl stop'
alias journal='journalctl -p 3 -xb'
alias journalf='journalctl -xe'

alias diskusage='du -sh -- * | sort -h'
alias duh='du -h --max-depth=1'
alias path='echo -e "${PATH//:/"\n"}"'

alias ge='gedit'
alias mi='micro'
alias na='nano'
alias ccat='bat'
alias cdiff='grc diff'
alias cls='clear'
alias cps='grc ps'
alias ctail='grc tail'
alias curl='curl -L'
alias ffind='fd'
alias lt='tree'
alias ntp-check='echo -e "\n[ Service ]"; systemctl is-active systemd-timesyncd; echo -e "\n[ timedatectl ]"; timedatectl status'
alias q='exit'
alias re-alias='source ~/.zshrc'
alias re-load='exec zsh'
alias wget='wget --hsts-file="$HOME/.cache/wget-hsts"'
alias yta='yt-dlp -f "bestaudio" --extract-audio --audio-format mp3 --audio-quality 5 --postprocessor-args "ffmpeg:-ar 24000 -ac 2"'
alias ytv='yt-dlp -f "bestvideo[height<=720]+bestaudio/best[height<=720]" --merge-output-format mp4 --postprocessor-args "ffmpeg:-ar 24000 -ac 2"'

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HIST_STAMPS="dd/mm/yyyy"
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

# --- Função extract()
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

