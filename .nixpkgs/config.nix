{
  packageOverrides = pkgs:
    rec {
      homeEnv = pkgs.buildEnv {
        name = "homeEnv";
        paths = [
          pkgs.bat
          pkgs.fd
          pkgs.fzf
          pkgs.gitAndTools.diff-so-fancy
          pkgs.gitAndTools.gitFull
          pkgs.glibcLocales
          pkgs.go
          pkgs.htop
          pkgs.jq
          pkgs.ncdu
          pkgs.nix
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
