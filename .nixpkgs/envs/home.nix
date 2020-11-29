{ pkgs }:
let
  py = pkgs.python3.withPackages(ps: with ps; [
    black
    ipython
    youtube-dl
  ]);
in pkgs.buildEnv {
  name = "home";
  paths = with pkgs; [
    bat
    direnv
    docker-compose
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
    travis
    vim
    xclip
    yq
    zsh
  ];
}
