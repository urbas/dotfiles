{ ... }:
let
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/55668eb671b915b49bcaaeec4518cc49d8de0a99.tar.gz";
    sha256 = "0b2mrrjsdpxpyvnv98dph5av3xjps1mbd87x8510mnc4pfa2zc8z";
  };

  inherit (import "${nixpkgsSrc}" {}) pkgs;
in {
  inherit pkgs;

  envs = {
    home = import ./envs/home.nix { inherit pkgs; };
    nix = import ./envs/nix.nix { inherit pkgs; };
  };
}
