{ pkgs }:

pkgs.buildEnv {
  name = "rightmove-scraping";
  paths = [(pkgs.python3.withPackages(ps: with ps; [
    ipython
  ]))];
}
