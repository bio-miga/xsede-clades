#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1

PROJ="$SCRATCH/query_genomes"
. ~/.miga_rc

if [[ -d $SCRATCH/query_genomes ]] ; then
  echo 'The query project already exists, refusing to run...' >&2
  exit 1
fi

miga new -P "$PROJ" -t genomes -m "db_proj_dir=$DATA"
echo "Launching daemon:"
miga daemon start -P "$PROJ" --shutdown-when-done
hostname > "$PROJ/daemon/hostname"

echo "Adding query datasets:"
while read sp ; do
  [[ -d $DATA/$sp ]] || continue
  # Query
  echo $sp
  q=$(miga ls -P "$DATA/$sp" | shuf | head -n 1)
  miga add -P "$PROJ" -D "$q" -t genome --query \
    --assembly "$DATA/$sp/data/05.assembly/${q}.LargeContigs.fna" \
    -m "db_project=$sp"
done < $1

