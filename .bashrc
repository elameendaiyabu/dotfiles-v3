#
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias d='cd ~/Development/'
alias g='cd ~/Github/'
alias gs='git status'
alias ga='git add .'
alias gl='git log'
alias gco='git checkout '
alias gcob='git checkout -b '
alias gss='git switch '
alias scripts='cd ~/.config/custom-scripts/'
alias dora='./.config/custom-scripts/dora.sh'
alias air='$(go env GOPATH)/bin/air'
alias bashfile='nvim ~/.bashrc'
alias cls='clear'
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias tor='sudo /usr/bin/tor'
alias vpn='sudo openvpn /etc/openvpn/client/vpn.protonvpn.udp.ovpn'
alias usvpn='sudo openvpn /etc/openvpn/client/us.protonvpn.udp.ovpn'
alias canadavpn='sudo openvpn /etc/openvpn/client/canada.protonvpn.udp.ovpn'
alias japanvpn='sudo openvpn /etc/openvpn/client/japan.protonvpn.udp.ovpn'
alias netherlandvpn='sudo openvpn /etc/openvpn/client/netherland.protonvpn.udp.ovpn'
alias crun='cc main.c && ./a.out'
alias count='ls -1 | wc -l'
alias deepseek='ollama run deepseek-r1:14b'
alias webui='DATA_DIR=~/.open-webui uvx --python 3.11 open-webui@latest serve'
alias pure='starship preset pure-preset -o ~/.config/starship.toml'
alias jetpack='starship preset jetpack -o ~/.config/starship.toml'
alias gruvbox='starship preset gruvbox-rainbow -o ~/.config/starship.toml'
alias torrent='qbittorrent --skip-dialog=true --sequential --save-path=/home/alamin/Videos/Torrents/'
alias mirror='sudo nano /etc/pacman.d/mirrorlist'
alias claude='~/.local/bin/claude'
alias w='wifitui'
# private aliases (tunnel tokens) live outside the repo
[ -f ~/.bashrc.secrets ] && . ~/.bashrc.secrets

PS1='[\u@\h \W]\$ '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
# fzf colours follow the system theme
[ -f ~/.config/themes/current/shell.sh ] && . ~/.config/themes/current/shell.sh

export PATH="$PATH:/home/alamin/.config/custom-scripts"
export "GTK_USE_PORTAL=1"
export PATH=$PATH:/home/alamin/.local/bin

#eval "$(oh-my-posh init bash --config ~/Github/themes/material.omp.json)"
eval "$(starship init bash)"

export EDITOR='nvim'
export VISUAL='nvim'
# attach to tmux session
function ta() {
    tmux a -t $1
}

# delete tmux session
function td() {
    tmux kill-session -t $1
}

# git commit
function gc() {
    git commit -m "$1 $2 $3 $4 $5 $6 $7 $8 $9"
}

# setup zoxide
eval "$(zoxide init bash --cmd cd)"
. "$HOME/.cargo/env"

export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

export MANPAGER="nvim +Man!"


# Load Angular CLI autocompletion.
# source <(ng completion script)
export PATH=$PATH:$HOME/go/bin

# Added by LM Studio CLI tool (lms)
export PATH="$PATH:/home/alamin/.lmstudio/bin"

export PATH=$PATH:$HOME/.local/share/bob/nvim-bin
export PATH=$PATH:/usr/local/go/bin

# opencode
export PATH=/home/alamin/.opencode/bin:$PATH

# 'waydroid start' -> launch Weston + Waydroid UI; 'waydroid stop' -> stop session and Weston
waydroid() {
    case "$1" in
        start) waydroid-start ;;
        stop)  pkill -x scrcpy; command waydroid session stop; pkill -x weston ;;
        *)     command waydroid "$@" ;;
    esac
}
