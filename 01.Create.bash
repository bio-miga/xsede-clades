#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1

while read sp ; do
  [[ -d $DATA/$sp ]] && continue
  [[ -d $SCRATCH/$sp ]] && continue
  # Create
  wait_for running_updates 5 1
  echo $sp
  $SUITE/create.bash $sp
done < $1

