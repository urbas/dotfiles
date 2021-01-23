{ pkgs }:
let
  pyEnv = pkgs.python3.withPackages(ps: with ps; [
    black
    ipython
  ]);

  terraform = pkgs.terraform_0_14.withPlugins (plugins: with plugins; [ aws ]);

  paths = with pkgs; [
    awscli
    pyEnv
    terraform
  ];

in pkgs.buildEnv {
  name = "nixos-config-dev";
  inherit paths;
  passthru.paths = paths;
}