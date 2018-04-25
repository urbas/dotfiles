# Setup

```bash
sudo apt-get install -y zsh git && \
  chsh -s `which zsh`  && \
  ([ -d $HOME/.my-dotfiles ] || git clone --bare git@bitbucket.org:urbas/my-dotfiles.git $HOME/.my-dotfiles) && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME fetch && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME reset $HOME && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME checkout $HOME && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME submodule update --recursive --init
```

Also install [these fonts](https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf).
