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
        pkgs.htop
      ];
    };
  };
}
