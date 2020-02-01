# This expression uses a revision of nixpkgs that can build homeEnv on a Raspberry Pi running Raspbian
# To build this, run the following: nix-env -f $HOME/.nixpkgs/homeEnv.nix -vi homeEnv
let
  nixpkgsSrc = builtins.fetchTarball {
    # This rev comes from branch `unstable` (based on upstream `nixpkgs-unstable` with some patches for
    # raspbian and Ubuntu x86_64): https://github.com/urbas/nixpkgs/tree/unstable
    url = "https://github.com/urbas/nixpkgs/archive/4f181412757c03c771a2342e4dc3ab895b58b3fe.tar.gz";
    # Unstable nixpkgs:
    # url = "https://github.com/NixOs/nixpkgs-channels/archive/7184df6beb88c4f5f3186e5b73d5437a3461ceaf.tar.gz";
  };
  
  inherit (import "${nixpkgsSrc}" {}) pkgs;
in {
  envs = {
    home = import ./envs/home.nix { inherit pkgs; };
  };
}
