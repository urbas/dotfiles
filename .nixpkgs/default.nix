{ ... }:
let
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/78215a8395f4ca1ed801c62a1c4c3e77f2c7d29f.tar.gz";
    sha256 = "0b8hjrzxv41n2792nmy9ir9fzc82i40yg83yp2z8spq6rkywig0n";
  };

  inherit (import "${nixpkgsSrc}" {}) pkgs;
in {
  inherit pkgs;

  envs = {
    home = import ./envs/home.nix { inherit pkgs; };
  };
}
