#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1 species_name

if [[ ! -d "$DATA/$1" ]] ; then
  echo "Project does not exist: $1" >&2
  exit 1
fi

PROJ="$DATA/$1"
echo -e "$1\t$(ls "$PROJ/metadata" | wc -l)\t$(find "$PROJ" | wc -l)\t$(du -s "$PROJ"|cut -f 1)"

