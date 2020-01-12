# This expression uses a revision of nixpkgs that can build homeEnv on a Raspberry Pi running Raspbian
# To build this, run the following: nix-env -f $HOME/.nixpkgs/raspbian.nix -vi homeEnv
let
  nixpkgsSrc = builtins.fetchTarball {
    # This rev comes from branch `unstable`: https://github.com/urbas/nixpkgs/tree/unstable
    url = "https://github.com/urbas/nixpkgs/archive/39a340714b443cf7b7518711bff2b2f031a41ea1.tar.gz";
  };
in rec {
  nixpkgs = (import "${nixpkgsSrc}") {};
  inherit (nixpkgs) pkgs lib;

  matejConfig = import ./config.nix;
  inherit (matejConfig.packageOverrides pkgs) homeEnv;
}
