{
  packageOverrides = pkgs:
    let
      python = pkgs.python3;
      pythonPackages = python.pkgs;

      philips-air-purifier = pythonPackages.buildPythonPackage (with pythonPackages; rec {
        pname = "philips-air-purifier";
        version = "0.0.5";
        checkInputs = [ pytest pytestrunner pytestcov ];
        propagatedBuildInputs = [ pycryptodome requests ];
        src = fetchPypi {
          inherit pname version;
          sha256 = "1xw37sjph1cvdidr8mkk412kshs11271ri6ggsa63ajyz8839q9m";
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
