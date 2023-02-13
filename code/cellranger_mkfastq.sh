#!/bin/bash
#SBATCH --partition=regular
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=100G
#SBATCH --time=48:00:00
#SBATCH --job-name=G000304_mkfastq.sh
#SBATCH --output=cellranger_mkfastq_%A.out

# Prepare FASTQ files for cellranger count|multi by running cellranger mkfastq
# to convert BCLs to FASTQs or by symlinking to the relevant FASTQ files
# Peter Hickey
# 2023-08-13

# NOTE: This was sample was captured over 1 GEM wells (G000304_1,
#       G000304_2) and sequenced over 1 Illumina run:
#
#       1. S000373: GEX, ADT, and HTO of G000304_1 and G000304_2
#                   @ WEHI on NextSeq2000.
#
#       Samples sequenced @ WEHI need to be run through cellranger mkfastq.

# Setup ------------------------------------------------------------------------

module load cellranger/7.0.0
module load bcl2fastq/2.19.1

# Project specific variables ---------------------------------------------------

PROJECT="G000304_Broomfield"
PROJECT_ROOT="/stornext/Projects/score/Analyses/${PROJECT}"
DATA=${PROJECT_ROOT}/data
EXTDATA=${PROJECT_ROOT}/extdata

# S000373 ----------------------------------------------------------------------

SAMPLESHEET_GEX_S000373=${DATA}/sample_sheets/GEX_library_barcodes.S000373.csv
SAMPLESHEET_ADT_HTO_S000373=${DATA}/sample_sheets/ADT_HTO_sample_sheet.S000373.csv
TARRED_BCLDIR_S000373=${EXTDATA}/S000373/data/raw/S000373.tar
# NOTE: Excluding the final '/230209_VH00914_159_AAAVCJCHV_7009_lingL_S373'
#       because otherwise end up with this weird repetition of this as the
#       penultimate and ultimate top-level directory. THis is re-added a few
#       lines down.
BCLDIR_S000373=/vast/scratch/users/hickey/${PROJECT}/S000373/data/bcl
mkdir -p ${BCLDIR_S000373}
tar -xvf ${TARRED_BCLDIR_S000373} --directory ${BCLDIR_S000373}
BCLDIR_S000373=${BCLDIR_S000373}//230209_VH00914_159_AAAVCJCHV_7009_lingL_S373
FASTQ_GEX_S000373=${EXTDATA}/S000373/data/fastq_GEX
mkdir -p ${FASTQ_GEX_S000373}
FASTQ_ADT_HTO_S000373=${EXTDATA}/S000373/data/fastq_ADT_HTO
mkdir -p ${FASTQ_ADT_HTO_S000373}

# NOTE: CellRanger writes a bunch of output to $(pwd) so have to move to the
#       directory where you want the output to go. Sigh.
cd ${FASTQ_GEX_S000373} || exit
cellranger mkfastq --run=${BCLDIR_S000373} \
                   --simple-csv=${SAMPLESHEET_GEX_S000373} \
                   --jobmode=local \
                   --localcores=20 \
                   --localmem=100

# NOTE: CellRanger can't process ADT and HTO with bcl2fastq, so have to run
#       this 'manually'.
bcl2fastq -R ${BCLDIR_S000373} \
          -o ${FASTQ_ADT_HTO_S000373} \
          --create-fastq-for-index-reads \
          --sample-sheet ${SAMPLESHEET_ADT_HTO_S000373}

