{ pkgs }:
pkgs.buildEnv {
  name = "nix";
  paths = with pkgs; [
    nix
  ];
}
