{ pkgs, extraPaths ? [] }:
let
  py = pkgs.python3.withPackages(ps: with ps; [
    black
    ipython
  ]);
in pkgs.buildEnv {
  name = "home";
  paths = with pkgs; [
    bat
    direnv
    entr
    fd
    file
    fzf
    gitAndTools.delta
    gitAndTools.gitFull
    glibcLocales
    htop
    hyperfine
    jq
    ncdu
    nix
    py
    ripgrep
    starship
    tldr
    tmux
    vim
    xclip
    yq
    zsh
  ] ++ extraPaths;
}
