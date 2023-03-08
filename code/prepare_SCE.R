# Create SingleCellExperiment object from 10X data and identify empty droplets
# using DropletUtils.
# Peter Hickey
# 2023-03-08

# Setup ------------------------------------------------------------------------

library(DropletUtils)
library(here)

source(here("code", "md5-utils.R"))

dir.create(here("extdata", "SCEs"), recursive = TRUE)
dir.create(here("extdata", "emptyDrops"))
dir.create(here("data", "md5"))

# Construct SingleCellExperiment object ----------------------------------------

capture_names <- paste0("G000304_", 1:2)
capture_names <- setNames(capture_names, capture_names)
captures <- setNames(
  here(
    "extdata",
    "CellRanger",
    capture_names,
    "outs",
    "multi",
    "count",
    "raw_feature_bc_matrix"),
  capture_names)
sce <- read10xCounts(samples = captures, col.names = TRUE)
stopifnot(!anyDuplicated(colnames(sce)))
sce <- splitAltExps(
  sce,
  rowData(sce)$Type,
  "Gene Expression")

# Identify empty droplets ------------------------------------------------------

set.seed(100)
list_of_empties <- lapply(capture_names, function(cn) {
  message(cn)
  emptyDrops(counts(sce)[, sce$Sample == cn])
})

# Check if more permutations are needed; see
# https://osca.bioconductor.org/quality-control.html#testing-for-empty-droplets
more_permutations_needed <- sapply(list_of_empties, function(e) {
  table(
    Sig = e$FDR <= 0.001,
    Limited = e$Limited)[1, 2] > 0
})
stopifnot(all(!more_permutations_needed))

# Save outputs -----------------------------------------------------------------

saveRDSWithMD5(
  object = sce,
  file = here(
    "extdata",
    "SCEs",
    "G000304_Broomfield.CellRanger.SCE.rds"))

for (cn in capture_names) {
  message(cn)
  empties <- list_of_empties[[cn]]
  saveRDSWithMD5(
    object = empties,
    file = here("extdata", "emptyDrops", paste0(cn, ".emptyDrops.rds")))

  writeLines(
    text = sce[["Barcode"]][sce$Sample == cn][which(empties$FDR <= 0.001)],
    con = here(
      "extdata",
      "emptyDrops",
      paste0(cn, ".barcodes.txt")))
}
