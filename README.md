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

Unfortunately, there is no nix binary dist for Raspberry Pi, so run this to install it on non-Raspberry Pi machines:
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

## Ctrl+Shift+e starts weird emoji typing
You can unset this with:
```
ibus-setup
```

Look for emoji and delete the shortcut.

# How to build nix for Raspbian on an amd64 Linux?
Use the `feature/armv7l-crosscompile` branch of the nixpkgs repo with this command:
```bash
nix-build . --arg crossSystem '{ config = "armv7l-unknown-linux-gnueabihf"; }' -A pkgs.nix
```