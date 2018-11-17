# Setup

```bash
sudo apt-get install -y zsh git && \
  chsh -s /bin/zsh  && \
  ([ -d $HOME/.my-dotfiles ] || git clone --bare git@bitbucket.org:urbas/my-dotfiles.git $HOME/.my-dotfiles) && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME fetch && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME reset $HOME && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME checkout $HOME && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME submodule update --recursive --init
```

Unfortunately, there is no nix binary dist for Raspberry PI, so run this to install it:
```bash
sudo mkdir -p /nix && sudo chown $USER:$USER /nix && sh <(curl https://nixos.org/nix/install) --no-daemon && \
  (. /home/matej/.nix-profile/etc/profile.d/nix.sh; nix-env -i homeEnv)
```

Change the fonts of your terminal to `Inconsolata for Powerline` (the fonts should be already installed).

# Troubleshooting

## How to change desktop shortcuts not configurable via Settings in ubuntu?
Via dconf-editor (under `org.gnome.desktop.wm.keybindings`).

Install dconf-editor and run it:
```
sudo apt install -y dconf-editor
dconf-editor
```

Answer from here: https://askubuntu.com/a/997267