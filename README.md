# Setup

Prerequisites: `nix`, `zsh`, and `git`.

Make sure `zsh` is your default shell:

```bash
chsh -s /bin/zsh
```

Dotfiles setup:

```bash
# NB: use the https remote if you do not have a GitHub account
REMOTE=https://github.com/urbas/dotfiles.git
[ -d $HOME/.my-dotfiles ] || git clone --bare ${REMOTE:-git@github.com:urbas/dotfiles.git} $HOME/.my-dotfiles
git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME fetch
git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME reset $HOME
git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME checkout $HOME
git --git-dir=$HOME/.my-dotfiles --work-tree=$HOME pull

# This loads the environment variables and aliases used below
exec zsh

mkdir -p $HOME/.local/state/nix/profiles

# This installs only CLI tools
np add ~/.nixpkgs#cli

# This installs both CLI tools and GUI tools
np add ~/.nixpkgs#gui
```

Change the fonts of your terminal to `Inconsolata Nerd Font Mono` (installed
by the `gui` profile; run `fc-cache -f` if it does not show up).

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
