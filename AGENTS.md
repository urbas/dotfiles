# Nix environment

This repo's Nix flake lives in `.nixpkgs/flake.nix`, not at the top level.
Add missing CLI tools you need for development to the devShell in `.nixpkgs/flake.nix` and use `nix develop .nixpkgs# --command <command>` to run them.

# Style

Don't add inline comments to code unless explicitly asked by the user.

# Git

Assume the working directory is the repo root; no need to use `git -C`.

When force-pushing, prefer `--force-with-lease` over `--force`.

Use simple single-line commit messages.

# Shell commands

Never run `find` over `/` or `/nix/store` — the tree is huge and it takes way
too long. Scope `find` to a specific project/subdirectory instead.

# Secrets

Do not print decrypted secrets or read them into the conversation. Pass secret
values directly from their source to the command that needs them.

# Memory

Do not store repository instructions in agent-specific memory. Update
`AGENTS.md` instead.
