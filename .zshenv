EDITOR=vim
LC_CTYPE="C.UTF-8"
LANG="$LC_CTYPE"
LANGUAGE="$LC_CTYPE"
LC_ALL="$LC_CTYPE"

if test "${PATH#*$HOME/.nix-profile/bin}" = "$PATH"; then
  PATH=$HOME/.nix-profile/bin:$PATH
fi
