{
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forSupportedSystems = f: with nixpkgs.lib; foldl' (resultAttrset: system: recursiveUpdate resultAttrset (f { inherit system; pkgs = import nixpkgs { inherit system; }; })) {} supportedSystems;

    in forSupportedSystems ({ pkgs, system, ... }:
      let
        homeEnv = import ./envs/home.nix { inherit pkgs; };
        mkInputSourceCache = input: pkgs.runCommand "${baseNameOf (toString input)}" { } "mkdir $out && ln -s ${input} $out/$(basename ${input})";
        input-sources = map mkInputSourceCache [nixpkgs];

      in {
        devShells.${system}.default = pkgs.stdenvNoCC.mkDerivation { name = "dotfiles"; buildInputs = homeEnv.paths ++ input-sources; };
        packages.${system} = {
          inherit homeEnv pkgs;
          default = homeEnv;
        };
      }
    );
}
