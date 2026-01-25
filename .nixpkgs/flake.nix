{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-25.11";
  inputs.nixpkgsMaster.url = "nixpkgs/master";

  outputs =
    {
      self,
      nixpkgs,
      nixpkgsMaster,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachSystem
      [
        "x86_64-linux"
        "aarch64-linux"
      ]
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          pkgsMaster = nixpkgsMaster.legacyPackages.${system};

          cliTools = with pkgs; [
            bat
            delta
            direnv
            fd
            file
            fzf
            gdu
            git
            glibcLocales
            htop
            hyperfine
            jless
            jq
            ncdu
            nix-direnv
            oh-my-zsh
            pv
            python3
            python3.pkgs.ipython
            ripgrep
            starship
            tmux
            tree
            vim
            xclip
            yq
            zsh
            zstd
          ];

          guiTools = with pkgs; [
            chromium
            deluge
            firefox
            gimp
            keepassxc
            libreoffice
            pkgsMaster.opencode
            shotwell
            steam
            vlc
            vscode
            uv
            pkgsMaster.zed-editor
          ];

          devTools = with pkgs; [ nixfmt-rfc-style ];

          gui = pkgs.buildEnv {
            name = "gui";
            paths = cliTools ++ guiTools;
          };
          cli = pkgs.buildEnv {
            name = "cli";
            paths = cliTools;
          };

        in
        {
          devShells.default = pkgs.mkShell { buildInputs = devTools; };
          packages = {
            inherit cli gui;
          };
          legacyPackages = {
            inherit pkgs pkgsMaster;
          };
        }
      );
}
