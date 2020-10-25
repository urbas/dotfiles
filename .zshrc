# oh-my-zsh
DISABLE_AUTO_UPDATE="true"
plugins=(git)
ZSH=$HOME/.oh-my-zsh source $HOME/.oh-my-zsh/oh-my-zsh.sh

# starship
eval "$(starship init zsh)"

# custom stuff
source $HOME/.zshrc-custom
