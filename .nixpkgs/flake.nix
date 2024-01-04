{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
    with nixpkgs.legacyPackages.${system}; rec {
      devShells.default = mkShell { buildInputs = packages.default.paths; };
      packages.default = import ./envs/home.nix { inherit pkgs; };
      legacyPackages = pkgs;
    });
}
