# This expression uses a revision of nixpkgs that can build homeEnv on a Raspberry Pi running Raspbian
# To build this, run the following: nix-env -f $HOME/.nixpkgs/homeEnv.nix -vi homeEnv
let
  # nixpkgsSrc = /home/mat/programming/nixpkgs;
  nixpkgsSrc = builtins.fetchTarball {
    # This rev comes from branch `unstable` (based on upstream `nixpkgs-unstable` with some patches for
    # raspbian and Ubuntu x86_64): https://github.com/urbas/nixpkgs/tree/unstable
    url = "https://github.com/urbas/nixpkgs/archive/urbas-2020-02-01.tar.gz";
    sha256 = "173lx16cxabcxqhha82x9g2irzpx7hhbi3425q994zl0gwm9x6kf";
    # Unstable nixpkgs:
    # url = "https://github.com/NixOs/nixpkgs-channels/archive/7184df6beb88c4f5f3186e5b73d5437a3461ceaf.tar.gz";
  };
  
  inherit (import "${nixpkgsSrc}" {}) pkgs;
in {
  inherit pkgs;

  envs = {
    home = import ./envs/home.nix { inherit pkgs; };
    nix = import ./envs/nix.nix { inherit pkgs; };
  };
}
