{
  packageOverrides = pkgs:
  rec {
    homeEnv = pkgs.buildEnv {
      name = "homeEnv";
      paths = [
        pkgs.ag
        pkgs.bat
        pkgs.fd
        pkgs.fzf
        pkgs.gitAndTools.diff-so-fancy
        pkgs.htop
        pkgs.ncdu
        pkgs.tldr
      ];
    };
  };
}
