#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1
source $HOME/.miga_rc

echo -e "dataset\tdaemon\tpreproc_avg\tdistances_avg\tproject\tdatasets"
while read sp ; do
  [[ -d $DATA/$sp ]] || continue
  $SUITE/timer/profile.bash $sp
done < $1

