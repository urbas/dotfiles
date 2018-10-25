{
  packageOverrides = pkgs:
  rec {
    homeEnv = pkgs.buildEnv {
      name = "homeEnv";
      paths = [ pkgs.bat ];
    };
  };
}
