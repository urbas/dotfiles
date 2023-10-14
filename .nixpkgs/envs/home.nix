{ pkgs }:
let
  paths = with pkgs; [
    awscli
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
    python3
    python3.pkgs.ipython
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