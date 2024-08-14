{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-24.05";

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
        chromium
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

      devTools = with pkgs; [
        nixpkgs-fmt
      ];

      gui = pkgs.buildEnv { name = "gui"; paths = cliTools ++ guiTools; };
      cli = pkgs.buildEnv { name = "cli"; paths = cliTools; };

    in
    {
      devShells.default = mkShell { buildInputs = devTools; };
      packages = { inherit cli gui; };
      legacyPackages = pkgs;
    });
}
