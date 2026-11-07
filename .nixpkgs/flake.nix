{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-26.05";
  inputs.nixpkgsMaster.url = "nixpkgs/master";
  inputs.nixpkgsUnstable.url = "nixpkgs/nixos-unstable";

  outputs =
    {
      self,
      nixpkgs,
      nixpkgsMaster,
      nixpkgsUnstable,
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
          nixpkgsArgs = {
            inherit system;
            config.allowUnfree = true;
          };

          pkgs = import nixpkgs nixpkgsArgs;
          pkgsMaster = import nixpkgsMaster nixpkgsArgs;
          pkgsUnstable = import nixpkgsUnstable nixpkgsArgs;

          cliTools = with pkgs; [
            bat
            delta
            direnv
            fd
            file
            fzf
            gdu
            gh
            git
            glibcLocales
            helix
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
            tree
            vim
            xclip
            yq
            pkgsUnstable.zellij
            zsh
            zstd
          ];

          guiTools = with pkgs; [
            alacritty
            chromium
            firefox
            gimp
            keepassxc
            libreoffice
            nerd-fonts.inconsolata
            pkgsUnstable.claude-code
            pkgsUnstable.codex
            pkgsUnstable.zed-editor
            shotwell
            steam
            vlc
          ];

          devTools = with pkgs; [ nixfmt ];

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
            inherit pkgs pkgsMaster pkgsUnstable;
          };
        }
      );
}
