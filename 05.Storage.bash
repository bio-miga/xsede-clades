#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1
source $HOME/.miga_rc

echo -e "dataset\tdatasets\tinodes\tsize"
while read sp ; do
  [[ -d $DATA/$sp ]] || continue
  $SUITE/size.bash $sp
done < $1

