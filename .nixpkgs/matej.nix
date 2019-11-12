let
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/urbas/nixpkgs/archive/51814d1de00d604bba71296de4d5aeb19cdcfc6e.tar.gz";
  };
in rec {
  nixpkgs = (import "${nixpkgsSrc}") {};
  inherit (nixpkgs) pkgs lib;

  matejConfig = import ./config.nix;
  inherit (matejConfig.packageOverrides pkgs) homeEnv;
}
