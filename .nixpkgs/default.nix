{ ... }:

rec {
  nixpkgs-src = import ./nixpkgs-src.nix;
  inherit (import nixpkgs-src { }) pkgs;

  envs = {
    home = import ./envs/home.nix { inherit pkgs; };
    nixpkgs-src = pkgs.buildEnv { name = "nixpkgs-src"; paths = [ nixpkgs-src ]; };
  };
}
