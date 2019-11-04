let
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/urbas/nixpkgs/archive/09d24d12bb70c75206c0c99222d02186f9ce7539.tar.gz";
  };
in rec {
  nixpkgs = (import "${nixpkgsSrc}") {};
  inherit (nixpkgs) pkgs lib;

  matejConfig = import ./config.nix;
}
