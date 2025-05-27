if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && \. "/usr/local/opt/nvm/etc/bash_completion"

export ZDOTDIR=$HOME/.config/zsh

DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_AUTO_TITLE="true"

plugins=(git tmux)

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_TMUX_AUTOSTART=true

# Ghostty
XDG_CONFIG_HOME="$HOME/.config/ghostty"

source $ZSH/oh-my-zsh.sh
source $HOME/.variables

# Docker aliases
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gcm="git commit -m"
alias gpl="git pull"
alias gp="git push"
alias gs="git status"
alias dp="docker ps"

# WS work
alias stack="cd $WS_WORKSPACE/tools/development-stack/docker-compose/app"
alias upstack="docker compose -f $WS_WORKSPACE/tools/development-stack/docker-compose/app/docker-compose.yml -f $WS_WORKSPACE/tools/development-stack/docker-compose/app/docker-compose.yml up -d"
alias downstack="docker compose -f $WS_WORKSPACE/tools/development-stack/docker-compose/app/docker-compose.yml -f $WS_WORKSPACE/tools/development-stack/docker-compose/app/docker-compose.yml down"
alias pullstack="docker compose -f $WS_WORKSPACE/tools/development-stack/docker-compose/app/docker-compose.yml -f $WS_WORKSPACE/tools/development-stack/docker-compose/app/docker-compose.yml pull"
alias dlws="docker login $WS_REGISTRY_ADDRESS -u $WS_REGISTRY_USERNAME -p $WS_REGISTRY_PASS"
alias dlwstb="docker login -u $TB_REGISTRY_USERNAME -p $TB_REGISTRY_PASSWORD $TB_REGISTRY_ADDRESS"
alias ws="cd $WS_WORKSPACE"
alias startvpn="sudo sh $HOME/.config/scripts/start_vpn.sh $WS_VPN_PATH"
alias endvpn="sudo sh $HOME/.config/scripts/kill_vpn.sh"
alias workstart="sh $HOME/.config/scripts/work_start.sh"
alias workend="sh $HOME/.config/scripts/work_end.sh"

# P2P
alias p2p="cd $HOME/dev/api" 
alias p2ptestnet="ssh $P2P_TESTNET_IP"
alias p2pdev="ssh $P2P_DEV_IP"
alias p2papi="ssh $P2P_API_IP"
alias p2pfrontend="ssh $P2P_FRONTEND_IP"
alias p2padmin="ssh $P2P_ADMIN_IP"
alias p2peth="ssh $P2P_ETH_IP"
alias p2pbtc="ssh $P2P_BTC_IP"
alias p2psentry="ssh $P2P_SENTRY_IP"
alias p2prunners="ssh $P2P_RUNNERS_IP"
alias dlp2p="docker login $P2P_REGISTRY_ADDRESS -u $P2P_REGISTRY_USERNAME -p $P2P_REGISTRY_PASSWORD"

# Nvim config
alias nvimconf="cd $HOME/.config/nvim"

# Nvim
alias v="nvim"

# Misc
alias cat="bat"
alias l="eza --icons"
alias la="eza -al --icons"
alias ll="eza -l --icons"
alias y="yazi"
alias reload="source $HOME/.config/zsh/.zshrc"

phpstorm() { /Applications/PhpStorm.app/Contents/MacOS/phpstorm $* &> /dev/null &| }

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
