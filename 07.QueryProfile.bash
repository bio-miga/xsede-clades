#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"

PROJ="$SCRATCH/query_genomes"
. ~/.miga_rc

if [[ ! -d "$PROJ" ]] ; then
  echo 'The query project does not exist.' >&2
  exit 1
fi

$SUITE/timer/query-time.rb "$PROJ"

