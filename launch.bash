#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1 species_name

if [[ ! -d "$SCRATCH/$1" ]] ; then
  echo "Project does not exist: $1" >&2
  exit 1
fi

cd $SCRATCH
JID=$(MIGA_CLADE=$1 \
  sbatch \
    --job-name="C:launch-$1" --output="$SCRATCH_LOG/launch.%j.out" \
    "$SUITE/launch.slurm" \
    | perl -pe 's/.* //')
echo "$JID" > "$1/launch.jid"
echo "- Launching clade in job '$JID'"

