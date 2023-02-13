#!/bin/bash
#SBATCH --partition=regular
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=100G
#SBATCH --time=48:00:00
#SBATCH --job-name=G000304_multi.sh
#SBATCH --output=cellranger_multi_%A_%a.out
#SBATCH --array=1-2

# Run cellranger multi
# Peter Hickey
# 2023-02-14

# NOTE: This was sample was captured over 2 GEM wells (G000304_1, G000304_2).

# Setup ------------------------------------------------------------------------

module load cellranger/7.0.0

# Project specific variables ---------------------------------------------------

PROJECT="G000304_Broomfield"
PROJECT_ROOT="/stornext/Projects/score/Analyses/${PROJECT}"
CAPTURE=G000304_${SLURM_ARRAY_TASK_ID}

CELLRANGERDIR=/vast/scratch/users/hickey/${PROJECT}/CellRanger
mkdir -p ${CELLRANGERDIR}
EXTDATA=${PROJECT_ROOT}/extdata/CellRanger/${CAPTURE}
mkdir -p ${EXTDATA}
OUTDIR=${PROJECT_ROOT}/output/CellRanger/${CAPTURE}
mkdir -p ${OUTDIR}

# NOTE: CellRanger writes a bunch of output to $(pwd) so have to move to the
#       directory where you want the output to go. Sigh.
cd ${CELLRANGERDIR} || exit
cellranger multi --id=${CAPTURE} \
                 --csv=${PROJECT_ROOT}/data/sample_sheets/${CAPTURE}.config.csv \
                 --localcores=20 \
                 --localmem=100

# Copy outputs
rsync --verbose --human-readable --recursive --progress --archive \
  ${CELLRANGERDIR}/${CAPTURE}/outs \
  ${EXTDATA}
cp ${CELLRANGERDIR}/${CAPTURE}/outs/per_sample_outs/${CAPTURE}/web_summary.html \
   ${OUTDIR}/${CAPTURE}.web_summary.html
