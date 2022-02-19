{ ... }:
let
  nixpkgs-src = import ./nixpkgs-src.nix;

  overlays = [
    (import ./overlays/1-pkgs.nix)
  ];

  inherit (import nixpkgs-src { inherit overlays; }) pkgs;
in {
  inherit pkgs;

  envs = {
    home = import ./envs/home.nix { inherit pkgs; };
    nixpkgs-src = pkgs.buildEnv { name = "nixpkgs-src"; paths = [ nixpkgs-src ]; };
  };
}
