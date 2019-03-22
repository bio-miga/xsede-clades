#!/bin/bash

. "$(dirname "$0")/../00.Paths.bash"
usage $1 species_name

if [[ ! -d "$DATA/$1" ]] ; then
  echo "Project does not exist: $1" >&2
  exit 1
fi

PROJ="$DATA/$1"
TIME="$SUITE/timer"
source $HOME/.miga_rc
echo -ne "$1\t"
echo -ne "$($TIME/daemon-time.rb "$PROJ")\t"
echo -ne "$($TIME/preproc-time.rb "$PROJ")\t"
echo -ne "$($TIME/distances-time.rb "$PROJ")\t"
echo -ne "$($TIME/project-time.rb "$PROJ")\t"
echo "$(miga ls -P "$PROJ" | wc -l)"

