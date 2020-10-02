EDITOR=vim
LC_CTYPE="en_GB.UTF-8"
LANG="$LC_CTYPE"
LANGUAGE="$LC_CTYPE"
LC_ALL="$LC_CTYPE"

NIX_HOME_ENV=/nix/var/nix/profiles/home
if echo $PATH | grep -qv $NIX_HOME_ENV/bin; then
  PATH=$NIX_HOME_ENV/bin:$PATH
fi

export NIX_PATH=matejpkgs=$HOME/.nixpkgs:$NIX_PATH