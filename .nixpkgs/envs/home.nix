{ pkgs }:
let
  paths = with pkgs; [
    awscli
    bat
    direnv
    entr
    fd
    file
    firefox
    fzf
    gparted
    gitAndTools.delta
    gitAndTools.gitFull
    glibcLocales
    htop
    hyperfine
    jq
    keepassxc
    libreoffice
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