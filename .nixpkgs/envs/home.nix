{ pkgs }:
let
  py = pkgs.python3.withPackages(ps: with ps; [
    black
    ipython
  ]);

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
  ];

in pkgs.buildEnv {
  name = "home";
  inherit paths;
  passthru.paths = paths;
}