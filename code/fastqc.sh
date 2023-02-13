#!/bin/bash
#SBATCH --cpus-per-task=40
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --time=24:00:00
#SBATCH --job-name=G000304_fastqc.sh
#SBATCH --output=fastqc_%A.out
#SBATCH --partition=regular

# Run FastQC.
# Peter Hickey
# 2023-02-14

# Setup ------------------------------------------------------------------------

module load fastqc

# Project specific variables ---------------------------------------------------

PROJECT="G000304_Broomfield"
PROJECT_ROOT="/stornext/Projects/score/Analyses/${PROJECT}"

# NOTE: Have to make sequencing run-specific output directories because some
#       FastQC files have the same name in different runs.
OUTDIR=${PROJECT_ROOT}/extdata/FastQC
mkdir -p ${OUTDIR}
mkdir -p ${OUTDIR}/S000373

# Run FastQC  ------------------------------------------------------------------

fastqc -o ${OUTDIR}/S000373 \
       --threads 40 \
       ${PROJECT_ROOT}/extdata/S000373/data/fastq_GEX/AAAVCJCHV/outs/fastq_path/AAAVCJCHV/G000304*fastq.gz \
       ${PROJECT_ROOT}/extdata/S000373/data/fastq_ADT_HTO/G000304*fastq.gz
