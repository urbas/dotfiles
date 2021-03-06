# oh-my-zsh
DISABLE_AUTO_UPDATE="true"
plugins=(git ssh-agent)
zstyle :omz:plugins:ssh-agent identities id_rsa
ZSH=$HOME/.oh-my-zsh source $HOME/.oh-my-zsh/oh-my-zsh.sh

# starship
eval "$(starship init zsh)"

# custom stuff
PROGRAMMING_DIR=$HOME/programming

# Nix
if [ -d $NIX_HOME_ENV ]; then
  export LOCALE_ARCHIVE_2_27="$NIX_HOME_ENV/lib/locale/locale-archive"
fi

nus-all() {
  (
    set -eo pipefail
    time nix-build ~/.nixpkgs --no-out-link -v $(nus-envs | xargs -n1 -I{} echo '-A envs.{}')
    nus-envs | xargs -P8 -n1 -I{} zsh -c 'nix-env -f ~/.nixpkgs -p /nix/var/nix/profiles/{} -iA envs.{} && nix-env -p /nix/var/nix/profiles/{} --delete-generations 30d'
    time nix-collect-garbage
    time nix-store --optimise
  )
}

nus-envs() {
  (
    set -eo pipefail
    NIX_PATH=nixroot=$HOME/.nixpkgs nix-instantiate --eval --json -E 'with import <nixroot> {}; builtins.attrNames envs' | jq -r '.[]'
  )
}

# Frequent directories aliases
alias n="cd $PROGRAMMING_DIR/nest"
alias p="cd $PROGRAMMING_DIR"

# General aliases
alias dotfiles="git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME"
alias gaip="ga -ip"
alias c="xclip -selection clipboard"
alias v="xclip -selection clipboard -o"
alias rf="rm -rf"

function yqh() {
  if [ $# -gt 0 ]; then
    yq -y $@ | bat -l yaml
  else
    yq -y '.' | bat -l yaml
  fi
}

# Better cli
if (( $+commands[bat] )); then
  alias cat="bat"
fi

export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git --exclude .cache'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type f"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

if (( $+commands[fzf-share] )); then
  . $(fzf-share)/key-bindings.zsh

  # Select and checkout a git branch
  fzf-branches-widget() {
    local selected
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    selected=( $(fd -t d --exact-depth 1 . ~/programming -x bash -c "git -C {} branch 2> /dev/null | sed -E 's,^\*(.*)$, \1 \o033[0;32m(current)\o033[0m,' | sed -E 's,^ ,\o033[0;34m{}\o033[0m,'" | grep -v 'HEAD detached' |
      FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --ansi -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
    local ret=$?
    if [ -n "$selected" ]; then
      cd ${selected[1]}
      git checkout ${selected[2]}
      echo
    fi
    zle reset-prompt
    return $ret
  }
  zle     -N   fzf-branches-widget
  bindkey '^Z' fzf-branches-widget
fi

if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi
