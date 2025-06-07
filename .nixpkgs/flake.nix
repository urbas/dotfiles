{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-25.05";
  inputs.nixpkgs-aider.url = "nixpkgs/master";

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-aider,
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
          pkgsAider = import nixpkgs-aider {
            inherit system;
            config.allowUnfree = true;
          };

          aider-chat = pkgsAider.aider-chat.withOptional {
            withBrowser = true;
            withPlaywright = true;
          };

          cliTools = with pkgs; [
            bat
            direnv
            fd
            file
            fzf
            gdu
            gitAndTools.delta
            gitAndTools.gitFull
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
            aider-chat
            chromium
            deluge
            firefox
            gimp
            keepassxc
            kitty
            libreoffice
            shotwell
            steam
            vlc
            vscode
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
            inherit pkgs pkgsAider;
          };
        }
      );
}
