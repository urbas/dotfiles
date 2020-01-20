{
  packageOverrides = pkgs:
    let
      python = pkgs.python3;
      pythonPackages = python.pkgs;

      philips-air-purifier = pythonPackages.buildPythonPackage (with pythonPackages; rec {
        name = "philips-air-purifier";
        version = "0.1.0";
        checkInputs = [ httmock pytest pytestrunner pytestcov ];
        propagatedBuildInputs = [ pycryptodome requests ];
        src = pkgs.fetchgit {
          url = "https://github.com/urbas/philips-air-purifier";
          rev = "687ab3a9a937cc2c672fb6e8059ddac2f55f43b6";
          sha256 = "1ywc4vj5nixs1min8ayvm1qipphhgmsnwz7n4vn3qj0py1m25pk5";
        };
      });

      py = python.withPackages(ps: with ps; [
        ipython
        philips-air-purifier
        youtube-dl
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
