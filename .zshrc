setopt inc_append_history

# oh-my-zsh
DISABLE_AUTO_UPDATE="true"
plugins=(git ssh-agent)
ZSH=$HOME/.nix-profile/share/oh-my-zsh source $HOME/.nix-profile/share/oh-my-zsh/oh-my-zsh.sh

# starship
eval "$(starship init zsh)"

# custom stuff
GIT_DIR=$HOME/git

# Nix
npu() {
  (
    set -ex
    nix profile upgrade --all
    nix profile wipe-history --older-than 21d
  )
}

# Frequent directories aliases
alias n="cd $GIT_DIR/nest"
alias p="cd $GIT_DIR"

# General aliases
alias c="xclip -selection clipboard"
alias v="xclip -selection clipboard -o"
alias rf="rm -rf"

# Useful functions
yqh() {
  if [ $# -gt 0 ]; then
    yq -y $@ | bat -l yaml
  else
    yq -y '.' | bat -l yaml
  fi
}

epoch2date() {
  date --date="@$1"
}

# Git aliases
alias dotfiles="git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME"
alias gaip="ga -ip"
alias gbgc="gb | grep -Ev '\*|master' | xargs -r -n1 git branch -d"

gri() {
  local _prevCommitIdx=$1
  shift
  git rebase -i --autosquash "$@" HEAD~$_prevCommitIdx
}

# Better cli
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git --exclude .cache'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type f"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

if (( $+commands[fzf] )); then
  source <(fzf --zsh)

  # Switch to a git repo and optionally checkout a git branch
  fzf-branches-widget() {
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    local selected=(
      $(
        fd -t d --exact-depth 1 . $GIT_DIR -x bash -c "printf '\e[31m{}\e[0m\n'; git -C {} branch 2> /dev/null | sed -E 's,^\*(.*)$, \1 \o033[0;32m(current)\o033[0m,' | sed -E 's,^ ,\o033[0;34m{}\o033[0m,'" \
          | grep -v 'HEAD detached' \
          | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --ansi -n2..,.. --tiebreak=index --bind=ctrl-z:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)
      )
    )
    local ret=$?
    if [ -n "$selected" ]; then
      cd ${selected[1]}
      if [[ -n "${selected[2]}" ]]; then
        git checkout ${selected[2]}
      fi
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

# Source local configuration if it exists
if [[ -f ~/.zshrc-local ]]; then
  source ~/.zshrc-local
fi
