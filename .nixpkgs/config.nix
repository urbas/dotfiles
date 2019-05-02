{
  packageOverrides = pkgs:
  rec {
    homeEnv = pkgs.buildEnv {
      name = "homeEnv";
      paths = [
        pkgs.bat
        pkgs.fd
        pkgs.fzf
        pkgs.gitAndTools.gitFull
        pkgs.gitAndTools.diff-so-fancy
        pkgs.go
        pkgs.glibcLocales
        pkgs.htop
        pkgs.jq
        pkgs.ncdu
        pkgs.ripgrep
        pkgs.tldr
        pkgs.tmux
        pkgs.travis
        pkgs.xclip
        pkgs.yq
      ];
    };
  };
}
