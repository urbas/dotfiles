{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-24.05";
  inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils, ... }: flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
    let
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      pkgsUnstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };

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
        jless
        jq
        ncdu
        oh-my-zsh
        pv
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
        pkgsUnstable.aider-chat
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
      devShells.default = pkgs.mkShell { buildInputs = devTools; };
      packages = { inherit cli gui; };
      legacyPackages = { inherit pkgs pkgsUnstable; };
    });
}
