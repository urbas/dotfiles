{ pkgs }:
let
  paths = with pkgs; [
    bat
    direnv
    fd
    file
    firefox
    fzf
    gitAndTools.delta
    gitAndTools.gitFull
    glibcLocales
    htop
    hyperfine
    jq
    keepassxc
    libreoffice
    ncdu
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
    vscode
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