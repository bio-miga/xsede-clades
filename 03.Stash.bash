#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1
source $HOME/.miga_rc

while read sp ; do
  [[ -d $DATA/$sp ]] && continue
  [[ -d $SCRATCH/$sp ]] || continue
  ls $SCRATCH/$sp/daemon/MiGA*.pid &>/dev/null && continue
  echo $sp
  if finished_project $sp ; then
    echo "- Done, stashing..."
    miga daemon stop -P $SCRATCH/$sp
    rsync -au $SCRATCH/$sp $DATA/ && rm -rf $SCRATCH/$sp
  fi
done < $1

