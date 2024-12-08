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
alias scripts='cd ~/.config/custom-scripts/'
alias dora='./.config/custom-scripts/dora.sh'
alias air='$(go env GOPATH)/bin/air'
alias bash='nvim ~/.bashrc'
alias cls='clear'
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias tor='sudo /usr/bin/tor'
alias vpn='sudo openvpn /etc/openvpn/client/vpn.protonvpn.udp.ovpn'

PS1='[\u@\h \W]\$ '


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

export PATH="$PATH:/home/alamin/.config/custom-scripts"
export "GTK_USE_PORTAL=1" 
export PATH=$PATH:/home/alamin/.local/bin

# eval "$(oh-my-posh init bash --config ~/Github/themes/material.omp.json)"
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
