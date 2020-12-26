{
  packageOverrides = pkgs: {
    homeEnv = (import ./envs/home.nix { inherit pkgs; }).env;
  };
}
