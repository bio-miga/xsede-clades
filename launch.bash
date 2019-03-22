#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1 species_name

if [[ ! -d "$SCRATCH/$1" ]] ; then
  echo "Project does not exist: $1" >&2
  exit 1
fi

cd $SCRATCH
. ~/.miga_rc
miga daemon start -P "$1" --shutdown-when-done
hostname > "$1/daemon/hostname"

