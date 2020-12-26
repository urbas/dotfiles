{ ... }:
let
  nixpkgsSrc = import ./nixpkgsSrc.nix;

  overlays = [
    (import ./overlays/1-pkgs.nix)
  ];

  inherit (import "${nixpkgsSrc}" { inherit overlays; }) pkgs;
in {
  inherit pkgs;

  envs = {
    nixpkgs-src = pkgs.buildEnv { name = "nixpkgs-src"; paths = [ nixpkgsSrc ]; };
    home = (import ./envs/home.nix { inherit pkgs; }).env;
  };
}
