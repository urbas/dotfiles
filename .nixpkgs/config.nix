{
  packageOverrides = pkgs:
    let
      philips-air-purifier = pkgs.python3.pkgs.buildPythonPackage rec {
        pname = "philips-air-purifier";
        version = "0.0.4";
        src = pkgs.python3.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "0000c9e5e7a16b6c88ba3088a9bfc82f7db8e13378be7c78d6c14a5f8ed05afd";
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
