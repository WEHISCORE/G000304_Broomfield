# EDA of emptyDrops() results.
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

# emptyDrops() -----------------------------------------------------------------

set.seed(100)
list_of_empties <- lapply(capture_names, function(cn) {
  message(cn)
  emptyDrops(counts(sce)[, sce$Sample == cn])
})

set.seed(100)
list_of_empties_30k <- lapply(capture_names, function(cn) {
  message(cn)
  emptyDrops(counts(sce)[, sce$Sample == cn], by.rank = 30000)
})

set.seed(100)
list_of_empties_50k <- lapply(capture_names, function(cn) {
  message(cn)
  emptyDrops(counts(sce)[, sce$Sample == cn], by.rank = 50000)
})

set.seed(100)
list_of_empties_100k <- lapply(capture_names, function(cn) {
  message(cn)
  emptyDrops(counts(sce)[, sce$Sample == cn], by.rank = 100000)
})


set.seed(181901)
list_of_empties2 <- lapply(capture_names, function(cn) {
  message(cn)
  emptyDrops(counts(sce)[, sce$Sample == cn])
})


sapply(list_of_empties, function(e) sum(e$FDR < 0.0001, na.rm = TRUE))
sapply(list_of_empties2, function(e) sum(e$FDR < 0.0001, na.rm = TRUE))
sapply(list_of_empties_30k, function(e) sum(e$FDR < 0.0001, na.rm = TRUE))
sapply(list_of_empties_50k, function(e) sum(e$FDR < 0.0001, na.rm = TRUE))
sapply(list_of_empties_100k, function(e) sum(e$FDR < 0.0001, na.rm = TRUE))

!identical(list_of_empties, list_of_empties2)
all.equal(list_of_empties, list_of_empties2)
all.equal(list_of_empties[[1]], list_of_empties2[[1]])

identical(
  which(list_of_empties[[1]]$FDR < 0.0001),
  which(list_of_empties2[[1]]$FDR < 0.0001))
identical(
  which(list_of_empties[[1]]$FDR < 0.0001),
  which(list_of_empties_30k[[1]]$FDR < 0.0001))
identical(
  which(list_of_empties[[1]]$FDR < 0.0001),
  which(list_of_empties_50k[[1]]$FDR < 0.0001))
identical(
  which(list_of_empties[[1]]$FDR < 0.0001),
  which(list_of_empties_100k[[1]]$FDR < 0.0001))

# Summary: Although outputs do change with repeated runnings of emptyDrops()
#          and with different parameters, we get the same number of non-empty
#          droplets regardless of parameter choices.

# Barcode plot -----------------------------------------------------------------

sce1 <- sce[, sce$Sample == "G000304_1"]
bcrank <- barcodeRanks(counts(sce1))

# Only showing unique points for plotting speed.
uniq <- !duplicated(bcrank$rank)
plot(bcrank$rank[uniq], bcrank$total[uniq], log="xy",
     xlab="Rank", ylab="Total UMI count", cex.lab=1.2)

abline(h=metadata(bcrank)$inflection, col="darkgreen", lty=2)
abline(h=metadata(bcrank)$knee, col="dodgerblue", lty=2)

legend("bottomleft", legend=c("Inflection", "Knee"),
       col=c("darkgreen", "dodgerblue"), lty=2, cex=1.2)

# Summary: All looks pretty good. There's a slight 'hump' around x = 1e3 but
#          it doesn't seem to be causing any problems when identifying the
#          knee or inflection point.

# Distribution of P-values for presumed empty droplets -------------------------

set.seed(100)
all.out <- emptyDrops(counts(sce1), lower = limit, test.ambient = TRUE)

set.seed(100)
all.out.30k <- emptyDrops(counts(sce1), by.rank = 30000, test.ambient = TRUE)

set.seed(100)
all.out.50k <- emptyDrops(counts(sce1), by.rank = 50000, test.ambient = TRUE)

set.seed(100)
all.out.100k <- emptyDrops(counts(sce1), by.rank = 100000, test.ambient = TRUE)

par(mfrow = c(2, 2))
hist(
  all.out$PValue[all.out$Total <= metadata(all.out)$lower & all.out$Total > 0],
  xlab = "P-value",
  col = "grey80",
  main = "all.out")
hist(
  all.out.50k$PValue[
    all.out$Total <= metadata(all.out.50k)$lower & all.out.50k$Total > 0],
  xlab = "P-value",
  col = "grey80",
  main = "all.out.50k")
hist(
  all.out.30k$PValue[
    all.out$Total <= metadata(all.out.30k)$lower & all.out.30k$Total > 0],
  xlab = "P-value",
  col = "grey80",
  main = "all.out.30k")
hist(
  all.out.100k$PValue[
    all.out.100k$Total <= metadata(all.out.100k)$lower & all.out.100k$Total > 0],
  xlab = "P-value",
  col = "grey80",
  main = "all.out.100k")

# Summary: P-value distributions all look fine.

# Summary ----------------------------------------------------------------------

# I can't detect anything unusual in the application of emptyDrops(). It seems
# that there are really fewer cells than we expected.
