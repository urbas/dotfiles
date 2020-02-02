FROM buildpack-deps:18.04-scm

# Place nix-bootstrap.tar.gz into this folder
# To get the nix-bootstrap tar: tar -czf nix-bootstrap.tar.gz -C / $(nix-store -qR $(which nix))
WORKDIR /nix-bootstrap
COPY ./ .

RUN tar -xzf nix-bootstrap.tar.gz
RUN rm nix-bootstrap.tar.gz

RUN useradd -m nix && chown -R nix:nix /nix /nix-bootstrap

USER nix

RUN /nix/store/$(ls /nix/store | grep -E -- '^[^-]*-nix-[0-9.]*$')/bin/nix --version
RUN /nix/store/$(ls /nix/store | grep -E -- '^[^-]*-nix-[0-9.]*$')/bin/nix-build . -A envs.nix
