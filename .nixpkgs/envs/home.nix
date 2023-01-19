{ pkgs }:
let
  py = pkgs.python3.withPackages(ps: with ps; [
    ipython
  ]);

  # oh-my-zsh does not end up in the `share/oh-my-zsh` folder. I have to move it
  oh-my-zsh-in-var-lib = pkgs.runCommand "oh-my-zsh-in-var-lib" {} ''
    mkdir -p $out/lib
    ln -s ${pkgs.oh-my-zsh}/share/oh-my-zsh $out/lib/oh-my-zsh
  '';

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
    oh-my-zsh-in-var-lib
    py
    ripgrep
    rustup
    rust-analyzer
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