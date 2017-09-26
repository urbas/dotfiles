# Setup

```bash
sudo apt-get install -y zsh && \
  chsh -s `which zsh`  && \
  git clone --bare git@bitbucket.org:urbas/my-dotfiles.git .my-dotfiles && \
  git --git-dir=.my-dotfiles --work-tree=$HOME reset . && \
  git --git-dir=.my-dotfiles --work-tree=$HOME checkout . && \
  git --git-dir=.my-dotfiles --work-tree=$HOME submodule update --recursive --init
```
