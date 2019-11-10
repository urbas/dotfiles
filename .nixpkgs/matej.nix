let
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/urbas/nixpkgs/archive/d81a65468059169536db7b27dca1fac0659c03e8.tar.gz";
  };
in rec {
  nixpkgs = (import "${nixpkgsSrc}") {};
  inherit (nixpkgs) pkgs lib;

  matejConfig = import ./config.nix;
  inherit (matejConfig.packageOverrides pkgs) homeEnv;
}
