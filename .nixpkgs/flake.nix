{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
    with (import nixpkgs { inherit system; config.allowUnfree = true; }); let

        cliTools = with pkgs; [
          bat
          direnv
          fd
          file
          fzf
          gitAndTools.delta
          gitAndTools.gitFull
          glibcLocales
          htop
          hyperfine
          jq
          ncdu
          oh-my-zsh
          python3
          python3.pkgs.ipython
          ripgrep
          starship
          tldr
          tmux
          tree
          vim
          xclip
          yq
          zsh
          zstd
        ];

        guiTools = with pkgs; [
          firefox
          gimp
          keepassxc
          libreoffice
          rustup
          shotwell
          steam
          vlc
          vscode
        ];

        guiEnv = pkgs.buildEnv { name = "gui"; paths = cliTools ++ guiTools; };
        cliEnv = pkgs.buildEnv { name = "cli"; paths = cliTools; };

      in {
      devShells.default = mkShell { buildInputs = cliTools ++ guiTools; };
      packages.gui = guiEnv;
      packages.cli = cliEnv;
      legacyPackages = pkgs;
    });
}
