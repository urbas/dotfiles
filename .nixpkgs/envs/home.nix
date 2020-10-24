{ pkgs }:
let
  py = pkgs.python3.withPackages(ps: with ps; [
    ipython
    (pkgs.callPackage ../python/philips-air-purifier.nix {})
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
    fzf
    gitAndTools.diff-so-fancy
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
    xclip
    yq
    zsh
  ];
}
