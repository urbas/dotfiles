# Setup

```bash
sudo apt-get install -y zsh git && \
  chsh -s /bin/zsh  && \
  ([ -d $HOME/.my-dotfiles ] || git clone --bare git@bitbucket.org:urbas/my-dotfiles.git $HOME/.my-dotfiles) && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME fetch && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME reset $HOME && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME checkout $HOME && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME pull && \
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME submodule update --recursive --init
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

## Ctrl+Shift+e starts weird emoji typing
You can unset this with:
```
ibus-setup
```

Look for emoji and delete the shortcut.

## How to build nix for Raspbian on an amd64 Linux?
Use `nixpkgs` that contains [my ARMv7l bugfix](https://github.com/NixOS/nixpkgs/pull/72480) and run this command:
```bash
NIX_PATH=nixpkgs=<YOUR CLONE> nix-build --arg crossSystem '{ config = "armv7l-unknown-linux-gnueabihf"; }' -A pkgs.nix
```
Rsync the resulting package to the Pi.

If you don't have a user environment, try doing this:
```bash
export PATH=/nix/store/k4c30by6r3ygczkzklkycafjdmd8mx08-nix-2.3.1/bin:$PATH
nix-env -f $HOME/.nixpkgs/matej.nix -vi matejConfig.homeEnv
```