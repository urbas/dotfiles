{
  packageOverrides = pkgs:
    let
      philips-air-purifier = pkgs.python3.pkgs.buildPythonPackage rec {
        pname = "philips-air-purifier";
        version = "0.0.4";
        checkInputs = [ pytest pytest-runner ];
        propagatedBuildInputs = [ pycryptodome requests ];
        src = pkgs.python3.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "0c2l9k1fk2by5nkgjx7g3h96d9b6y2nf1z01aygba68bl8i9cvx9";
        };
      };

      py = pkgs.python3.withPackages(ps: with ps; [
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
