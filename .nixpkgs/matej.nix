let
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/urbas/nixpkgs/archive/32b7613bf9aaa2346fa355b5fcda66d6c325b511.tar.gz";
  };
in rec {
  nixpkgs = (import "${nixpkgsSrc}") {};
  inherit (nixpkgs) pkgs lib;

  matejConfig = import ./config.nix;
  inherit (matejConfig.packageOverrides pkgs) homeEnv;
}
