{ ... }:
let
  nixpkgs-src = import ./nixpkgs-src.nix;

  overlays = [
    (import ./overlays/1-pkgs.nix)
  ];

  inherit (import "${nixpkgs-src}" { inherit overlays; }) pkgs;
in {
  inherit pkgs;

  envs = {
    nixpkgs-src = pkgs.buildEnv { name = "nixpkgs-src"; paths = [ nixpkgs-src ]; };
    home = import ./envs/home.nix { inherit pkgs; };
  };
}
