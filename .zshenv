EDITOR=vim
LC_CTYPE="C.UTF-8"
LANG="$LC_CTYPE"
LANGUAGE="$LC_CTYPE"
LC_ALL="$LC_CTYPE"

export MY_HOME_PROFILE=$HOME/.local/state/nix/profiles/home

path=("$MY_HOME_PROFILE/bin" $path)
export PATH

[[ ":${XDG_DATA_DIRS}:" != *":$MY_HOME_PROFILE/share:"* ]] && export XDG_DATA_DIRS="$MY_HOME_PROFILE/share${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
