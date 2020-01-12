# This expression uses a revision of nixpkgs that can build homeEnv on a Raspberry Pi running Raspbian
# To build this, run the following: nix-env -f $HOME/.nixpkgs/raspbian.nix -vi homeEnv
let
  nixpkgsSrc = builtins.fetchTarball {
    # This rev comes from branch `unstable` (based on upstream `nixpkgs-unstable` with some patches for
    # raspbian and Ubuntu x86_64): https://github.com/urbas/nixpkgs/tree/unstable
    url = "https://github.com/urbas/nixpkgs/archive/c246cf883cb0f013c93b5b6c0033f65147e28f86.tar.gz";
  };
in rec {
  nixpkgs = (import "${nixpkgsSrc}") {};
  inherit (nixpkgs) pkgs lib;

  matejConfig = import ./config.nix;
  inherit (matejConfig.packageOverrides pkgs) homeEnv;
}
