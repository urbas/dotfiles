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
    oh-my-zsh
    py
    ripgrep
    rustup
    starship
    tldr
    tmux
    tree
    vim
    xclip
    yq
    zsh
    zstd
  ];

in pkgs.buildEnv {
  name = "home";
  inherit paths;
  passthru.paths = paths;
}