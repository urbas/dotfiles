{
  packageOverrides = pkgs:
    rec {
      homeEnv = pkgs.buildEnv {
        name = "homeEnv";
        paths = with pkgs; [
          bat
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
          ripgrep
          tldr
          tmux
          travis
          xclip
          yq
        ];
      };
    };
}
