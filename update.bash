#!/bin/bash

. "$(dirname "$0")/00.Paths.bash"
usage $1 species_name

if [[ -d "$DATA/$1" ]] ; then
  echo "Project is already stashed: $1" >&2
  exit 1
fi

if [[ ! -d "$SCRATCH/$1" ]] ; then
  echo "Project does not exist: $1" >&2
  exit 1
fi

cd $SCRATCH
JID=$(MIGA_CLADE=$1 \
  sbatch \
    --job-name="C:update-$1" --output="$SCRATCH_LOG/update.%j.out" \
    "$SUITE/update.slurm" \
    | perl -pe 's/.* //')
echo "$JID" > "$1/update.jid"
echo "- Updating clade in job '$JID'"

