EDITOR=vim
LC_CTYPE="en_GB.UTF-8"
LANG="$LC_CTYPE"
LANGUAGE="$LC_CTYPE"
LC_ALL="$LC_CTYPE"

if [ -d /etc/profiles/per-user/$USER ]; then
  NIX_HOME_ENV=/etc/profiles/per-user/$USER
else
  NIX_HOME_ENV=/nix/var/nix/profiles/home
fi

if test "${PATH#*$NIX_HOME_ENV/bin}" = "$PATH"; then
  PATH=$NIX_HOME_ENV/bin:$PATH
fi

if test "${NIX_PATH#*matejpkgs=}" = "$NIX_PATH"; then
  export NIX_PATH=matejpkgs=$HOME/.nixpkgs:$NIX_PATH
fi

if test "${NIX_PATH#*nixpkgs=}" = "$NIX_PATH"; then
  export NIX_PATH=nixpkgs=$HOME/.nixpkgs/nixpkgs.nix:$NIX_PATH
fi