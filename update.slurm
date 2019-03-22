#!/bin/bash
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --export=ALL
#SBATCH -t 06:00:00

cd "$SLURM_SUBMIT_DIR/$MIGA_CLADE"
source "$HOME/.miga_rc"
date=$(date "+%y%m%d")
SP=$(echo $MIGA_CLADE | tr '_' ' ')

echo "
date: $date
MIGA_CLADE: $MIGA_CLADE
SP: $SP" >&2

[[ -e BLACKLIST.txt ]] || touch BLACKLIST.txt
[[ -e README.md ]] || echo "
All available genomes from the species *$SP*.

---

# Changelog
" > README.md

miga ls -P . --ref | sort > ${date}_local.txt
miga ncbi_get -P . -T "$SP" --all -v --no-version-name \
  -R ${date}_remote.txt.tmp --blacklist BLACKLIST.txt \
  --api-key 70caa4dfc93f073cc2dcb41d126973cba209 -d 1
sort ${date}_remote.txt.tmp > ${date}_remote.txt
rm ${date}_remote.txt.tmp

comm -1 -3 ${date}_remote.txt ${date}_local.txt > ${date}_unlink.txt
comm -2 -3 ${date}_remote.txt ${date}_local.txt > ${date}_new.txt

echo "
### Update $date
* Date: $(miga date)
* New datasets: $(wc -l < ${date}_new.txt)
* Deprecated datasets: $(wc -l < ${date}_unlink.txt)
* Total references: $(wc -l < ${date}_remote.txt)
" >> README.md

