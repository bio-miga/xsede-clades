#!/bin/bash

SUITE=$HOME/xsede-clades
SCRATCH=$HOME/scratch/Clades
SCRATCH_LOG=$HOME/scratch/Clades.log
DATA=$HOME/data/Clades

set -e

function usage {
  local arg=${2:-SpeciesList.txt}
  if [[ ! -n $1 ]] ; then
    echo "Usage: $0 $arg"
    exit 0
  fi
}

function wait_for {
  local fun=$1
  local max=$2
  local wait_t=${3:-1}
  while [[ $($fun) -ge $max ]] ; do
    let wait_t=$wait_t*2
    echo "- waiting for $fun: $wait_t sec"
    sleep $wait_t
  done
}

function running_updates {
  squeue -u $(whoami) | tail -n +2 | awk '$3=="C:update"' | wc -l
}

function running_launches {
  ps aux | awk '$1=="'$(whoami)'" && $11 ~ /MiGA/' | wc -l
}

function finished_project {
  local sp=$1
  [[ $(miga about -P $SCRATCH/$sp -p | grep -c queued) == 0 ]]
}

