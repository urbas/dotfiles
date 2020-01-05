{
  packageOverrides = pkgs:
    let
      python = pkgs.python3;
      pythonPackages = python.pkgs;

      philips-air-purifier = pythonPackages.buildPythonPackage (with pythonPackages; rec {
        pname = "philips-air-purifier";
        version = "0.0.4";
        preConfigure = ''

        '';
        checkPhase = ''
          pytest tests
        '';
        checkInputs = [ pytest pytestrunner pytestcov ];
        propagatedBuildInputs = [ pycryptodome requests ];
        src = fetchFromGithub {
          inherit pname version;
          owner = "urbas";
          repo = pname;
          rev = "74c0189284d3fbd8d345db401241ef5f759e4003";
          sha256 = "000l9k1fk2by5nkgjx7g3h96d9b6y2nf1z01aygba68bl8i9cvx9";
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
