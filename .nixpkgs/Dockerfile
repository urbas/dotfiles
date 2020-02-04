FROM alpine:3.11.3

# Place nix-bootstrap.tar.gz into this folder
# To get the nix-bootstrap tar: tar -cPzf nix-bootstrap.tar.gz -C / $(nix-store -qR $(which nix))
WORKDIR /nix-bootstrap
COPY ./ .

RUN tar -xzf nix-bootstrap.tar.gz -C /
RUN rm nix-bootstrap.tar.gz

RUN addgroup -S nix && adduser -S nix -G nix
RUN chown -R nix:nix /nix /nix-bootstrap

RUN apk --update upgrade && \
    apk add ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/*

USER nix

RUN /nix/store/$(ls /nix/store | grep -E -- '^[^-]*-nix-[0-9.]*$')/bin/nix --version
RUN /nix/store/$(ls /nix/store | grep -E -- '^[^-]*-nix-[0-9.]*$')/bin/nix-build . -A envs.nix
