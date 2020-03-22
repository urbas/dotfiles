# This expression uses a revision of nixpkgs that can build on a Raspberry Pi running Raspbian
{
  nixpkgsVersion ? "urbas-2020-03-22",
  nixpkgsSha ? "10k32gdbib378591c748104a0a713xkc4gj58b9b6l254b5albbi"
}:
let
  # nixpkgsSrc = /home/mat/programming/nixpkgs;
  nixpkgsSrc = builtins.fetchTarball {
    # This rev comes from branch `unstable` (based on upstream `nixpkgs-unstable` channel with some patches for
    # Raspbian): https://github.com/urbas/nixpkgs/tree/unstable
    # Check for updates at: https://github.com/NixOS/nixpkgs-channels/commits/nixpkgs-unstable
    url = "https://github.com/urbas/nixpkgs/archive/${nixpkgsVersion}.tar.gz";
    sha256 = nixpkgsSha;
  };

  inherit (import "${nixpkgsSrc}" {}) pkgs;
in {
  inherit pkgs;

  envs = {
    home = import ./envs/home.nix { inherit pkgs; };
    nix = import ./envs/nix.nix { inherit pkgs; };
  };
}
