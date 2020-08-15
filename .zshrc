# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
DISABLE_AUTO_UPDATE="true"
plugins=(git ssh-agent)
zstyle :omz:plugins:ssh-agent identities id_rsa
source $HOME/.oh-my-zsh/oh-my-zsh.sh

# starship
eval "$(starship init zsh)"

# custom stuff
source $HOME/.zshrc-custom
