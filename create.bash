#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1 species_name

if [[ -d "$DATA/$1" ]] ; then
  echo "Project is already stashed: $1" >&2
  exit 1
fi

if [[ ! -d "$SCRATCH/$1" ]] ; then
  cd $SCRATCH
  source $HOME/.miga_rc
  miga new -P "$1" -t clade
  $SUITE/update.bash "$1"
fi

