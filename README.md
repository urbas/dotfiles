# Setup

Prerequisites:
```bash
sudo apt-get install -y zsh git
chsh -s /bin/zsh
```

Dotfiles setup:
```bash
# NB: use the https remote if you do not have a GitHub account
(
  set -ex
  REMOTE=https://github.com/urbas/dotfiles.git
  [ -d $HOME/.my-dotfiles ] || git clone --bare ${REMOTE:-git@github.com:urbas/dotfiles.git} $HOME/.my-dotfiles
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME fetch
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME reset $HOME
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME checkout $HOME
  git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME pull
)
```

Change the fonts of your terminal to `Inconsolata for Powerline` (the fonts should be already installed).

# Upgrade dev env

1. Bump versions of dependencies:
    ```bash
    nix flake update ~/.nixpkgs
    ```

2. Install and test the upgraded tools:
    ```bash
    npi
    ```

3. Push the changes:
    ```bash
    dotfiles add ~/.nixpkgs
    dotfiles ci -m "bump nixpkgs"
    dotfiles push
    ```

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
