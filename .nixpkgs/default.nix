{ ... }:
let
  nixpkgsSrc = import ./nixpkgsSrc.nix;

  inherit (import "${nixpkgsSrc}" {}) pkgs;
in {
  inherit pkgs;

  envs = {
    nixpkgs-src = pkgs.buildEnv { name = "nixpkgs-src"; paths = [ nixpkgsSrc ]; };
    home = import ./envs/home.nix { inherit pkgs; };

    # programming shell envs
    vscode = pkgs.buildEnv { name = "vscode"; paths = with pkgs; [ nodejs yarn ]; };
    rightmove-scraping = import ./envs/rightmove-scraping.nix { inherit pkgs; };
  };
}
