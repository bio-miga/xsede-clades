#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1

while read sp ; do
  [[ -d $DATA/$sp ]] && continue
  [[ -d $SCRATCH/$sp ]] || continue
  ls $SCRATCH/$sp/daemon/MiGA*.pid &>/dev/null && continue
  # Launch
  wait_for running_launches 40 60
  echo $sp
  $SUITE/launch.bash $sp
done < $1

