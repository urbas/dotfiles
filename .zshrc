
# oh-my-zsh
source $HOME/.oh-my-zsh/lib/directories.zsh
source $HOME/.oh-my-zsh/lib/history.zsh
source $HOME/.oh-my-zsh/lib/git.zsh
source $HOME/.oh-my-zsh/plugins/git/git.plugin.zsh

# TODO: remove this once the above has been verified to work nicely
# export ZSH=$HOME/.oh-my-zsh
# DISABLE_AUTO_UPDATE="true"
# plugins=(git ssh-agent)
# zstyle :omz:plugins:ssh-agent identities id_rsa

# starship
eval "$(starship init zsh)"

# custom stuff
source $HOME/.zshrc-custom
