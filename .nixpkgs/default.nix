# This expression uses a revision of nixpkgs that can build on a Raspberry Pi running Raspbian
let
  # nixpkgsSrc = /home/mat/programming/nixpkgs;
  nixpkgsSrc = builtins.fetchTarball {
    # This rev comes from branch `unstable` (based on upstream `nixpkgs-unstable` channel with some patches for
    # raspbian and Ubuntu x86_64): https://github.com/urbas/nixpkgs/tree/unstable
    url = "https://github.com/urbas/nixpkgs/archive/urbas-2020-02-01.tar.gz";
    sha256 = "173lx16cxabcxqhha82x9g2irzpx7hhbi3425q994zl0gwm9x6kf";
  };
  
  inherit (import "${nixpkgsSrc}" {}) pkgs;
in {
  inherit pkgs;

  envs = {
    home = import ./envs/home.nix { inherit pkgs; };
    nix = import ./envs/nix.nix { inherit pkgs; };
  };
}
