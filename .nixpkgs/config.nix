{
  packageOverrides = pkgs:
    let
      python = pkgs.python3;
      pythonPackages = python.pkgs;

      philips-air-purifier = pythonPackages.buildPythonPackage (with pythonPackages; rec {
        name = "philips-air-purifier";
        version = "0.0.5";
        checkInputs = [ httmock pytest pytestrunner pytestcov ];
        propagatedBuildInputs = [ pycryptodome requests ];
        src = pkgs.fetchFromGitHub {
          owner = "urbas";
          repo = name;
          rev = "v${version}";
          sha256 = "07hrb1p8m46cd5kmxxjz5if1nx8d5h65y3v7px5zpsizli0hdfn4";
        };
      });

      py = python.withPackages(ps: with ps; [
        philips-air-purifier
      ]);
    in
      rec {
        homeEnv = pkgs.buildEnv {
          name = "homeEnv";
          paths = with pkgs; [
            bat
            fd
            fzf
            gitAndTools.diff-so-fancy
            gitAndTools.gitFull
            glibcLocales
            htop
            hyperfine
            jq
            ncdu
            nix
            py
            ripgrep
            tldr
            tmux
            travis
            xclip
            yq
          ];
        };
      };
}
