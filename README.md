# Setup

Prerequisites: `nix`, `zsh`, and `git`.

Make sure `zsh` is your default shell:

```bash
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

  # This installs only CLI tools
  nix profile install ~/.nixpkgs#cli

  # This installs both CLI tools and GUI tools
  nix profile install ~/.nixpkgs#gui
)
```

Change the fonts of your terminal to `Inconsolata for Powerline` (the fonts
should be already installed).

# Upgrade dev env

1. Bump versions of dependencies:

   ```bash
   nix flake update --flake ~/.nixpkgs
   ```

2. Install and test the upgraded tools:

   ```bash
   npu
   ```

3. Push the changes:
   ```bash
   dotfiles add ~/.nixpkgs
   dotfiles ci -m "bump nixpkgs"
   dotfiles push
   ```

# Troubleshooting

## How to change desktop shortcuts not configurable via Settings in ubuntu?

Via dconf-editor under `/org/gnome/desktop/wm/keybindings/` (you can get rid of
the `Ctrl+Alt+Shift+...` keybindings here).

Install dconf-editor and run it:

```bash
nix shell github:NixOS/nixpkgs/nixos-23.11#gnome.dconf-editor
dconf-editor
```

Answer from here: https://askubuntu.com/a/997267

## Ctrl+Shift+e starts weird emoji typing

You can unset this with:

```bash
ibus-setup
```

Look for emoji and delete the shortcut.
