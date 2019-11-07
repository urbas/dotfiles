let
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/urbas/nixpkgs/archive/a6f9c53a4b4d275b60f3d52b1bc22bb29fd48db8.tar.gz";
  };
in rec {
  nixpkgs = (import "${nixpkgsSrc}") {};
  inherit (nixpkgs) pkgs lib;

  matejConfig = import ./config.nix;
  inherit (matejConfig.packageOverrides pkgs) homeEnv;
}
