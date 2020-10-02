{ ... }:
let
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/1179840f9a88b8a548f4b11d1a03aa25a790c379.tar.gz";
    sha256 = "00jy37wj04bvh299xgal2iik2my9l0nq6cw50r1b2kdfrji8d563";
  };

  inherit (import "${nixpkgsSrc}" {}) pkgs;
in {
  inherit pkgs;

  envs = {
    nixpkgs-src = pkgs.buildEnv { name = "nixpkgs-src"; paths = [ nixpkgsSrc ]; };
    home = import ./envs/home.nix { inherit pkgs; };

    # programming shell envs
    vscode = pkgs.buildEnv { name = "vscode"; paths = with pkgs; [ nodejs yarn ]; };
  };
}
