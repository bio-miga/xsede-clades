#!/bin/bash
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --export=ALL
#SBATCH -t 06:00:00
#SBATCH -A get144

cd "$SLURM_SUBMIT_DIR/$MIGA_CLADE"
. "$HOME/.miga_rc"
date=$(date "+%y%m%d")
SP=$(echo $MIGA_CLADE | tr '_' ' ')

cat <<MSG >&2
date: $date
MIGA_CLADE: $MIGA_CLADE
SP: $SP
MSG

[[ -e README.md ]] || cat <<MD > README.md
All available genomes from the species *$SP*.

---

# Changelog
MD

miga ls -P . | sort > "${date}_local.txt"
miga ncbi_get --all -v -P . -T "$SP" --api-key "70caa4dfc93f073cc2dcb41d126973cba209"
miga ls -P . | sort > "${date}_remote.txt"

comm -1 -3 "${date}_remote.txt" "${date}_local.txt" > "${date}_unlink.txt"
comm -2 -3 "${date}_remote.txt" "${date}_local.txt" > "${date}_new.txt"

cat <<MD >> README.md
### Update $date
* Date: $(miga date)
* New datasets: $(wc -l < "${date}_new.txt")
* Deprecated datasets: $(wc -l < "${date}_unlink.txt")
* Total references: $(wc -l < "${date}_remote.txt")
MD

