# EDA of HTO demultiplexing
# Peter Hickey
# 2023-03-08

# NOTE: Picks up from around 'Demultiplexing with hashtag oligos (HTOs)' >
#       'Summary' section of demultiplexing.Rmd

tmp <- SingleCellExperiment(
  assays = list(counts = counts(altExp(sce, "HTO"))),
  colData = demuxmix_df)
tmp$Capture <- sce$Capture
sf <- librarySizeFactors(counts(tmp))
# NOTE: Kludge to workaround non-positive size factors (corresponding to
#       droplets with zero HTO counts).
sf <- pmax(sf, min(sf[sf > 0]))
sizeFactors(tmp) <- sf
tmp <- logNormCounts(tmp)
tmp$Type <- factor(
  tmp$Type,
  levels = c("multiplet", "singlet", "negative", "uncertain"))
# tmp$Confident <- factor(tmp$Confident, levels = c(TRUE, FALSE))
tmp$HTO <- factor(tmp$HTO, names(sort(table(tmp$HTO), decreasing = TRUE)))
tmp$Frequent <- table(tmp$HTO)[tmp$HTO] > 100
tmp$HTO2 <- droplevels(
  factor(
    ifelse(
      tmp$Frequent,
      as.character(tmp$HTO),
      "other"),
    c(levels(tmp$HTO), "other")))

tmp$Best <- factor(
  ifelse(
    tmp$HTO %in% valid_hto_combos_df$HTO,
    valid_hto_combos_df[
      match(tmp$HTO, valid_hto_combos_df$HTO), "Pool"],
    ifelse(
      tmp$Type == "singlet",
      "uncertain",
      demuxmix_df$Type)),
  levels = c(
    unique(valid_hto_combos_df$Pool),
    "multiplet", "negative", "uncertain"))

# Sort columns as we want the heatmap to appear.
tmp <- tmp[, order(tmp$HTO2, tmp$Best, tmp$Type, -tmp$Prob)]

# All cells --------------------------------------------------------------------

tmp2 <- tmp
colData(tmp2) <- droplevels(colData(tmp2))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = FALSE,
  fontsize = 6,
  fontsize_row = 8,
  zlim = c(-4, 4),
  main = "G000340",
  cluster_cols = FALSE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))

capture <- "G000304_1"
tmp2 <- tmp[, tmp$Capture == capture]
colData(tmp2) <- droplevels(colData(tmp2))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = FALSE,
  fontsize = 6,
  fontsize_row = 8,
  zlim = c(-4, 4),
  main = capture,
  cluster_cols = FALSE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))

capture <- "G000304_2"
tmp2 <- tmp[, tmp$Capture == capture]
colData(tmp2) <- droplevels(colData(tmp2))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = FALSE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = capture,
  cluster_cols = FALSE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))

# All frequent HTO combos ------------------------------------------------------

tmp2 <- tmp[, tmp$HTO2 != "other"]
colData(tmp2) <- droplevels(colData(tmp2))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Type", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = FALSE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = "G000304",
  cluster_cols = FALSE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))

capture <- "G000304_1"
tmp2 <- tmp[, tmp$Capture == capture & tmp$HTO2 != "other"]
colData(tmp2) <- droplevels(colData(tmp2))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Type", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = FALSE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = capture,
  cluster_cols = FALSE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))

capture <- "G000304_2"
tmp2 <- tmp[, tmp$Capture == capture & tmp$HTO2 != "other"]
colData(tmp2) <- droplevels(colData(tmp2))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Type", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = FALSE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = capture,
  cluster_cols = FALSE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))

# All other droplets (clustered) -----------------------------------------------

tmp2 <- tmp[, tmp$HTO2 == "other"]
colData(tmp2) <- droplevels(colData(tmp2))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Type", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = FALSE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = "G000340",
  cluster_cols = TRUE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Type", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = TRUE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = "G000340",
  cluster_cols = TRUE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))

capture <- "G000304_1"
tmp2 <- tmp[, tmp$Capture == capture & tmp$HTO2 == "other"]
colData(tmp2) <- droplevels(colData(tmp2))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Type", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = FALSE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = capture,
  cluster_cols = TRUE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Type", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = TRUE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = capture,
  cluster_cols = TRUE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))

capture <- "G000304_2"
tmp2 <- tmp[, tmp$Capture == capture & tmp$HTO2 == "other"]
colData(tmp2) <- droplevels(colData(tmp2))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Type", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = FALSE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = capture,
  cluster_cols = TRUE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))
plotHeatmap(
  tmp2,
  rownames(tmp2),
  color_columns_by = c("HTO2", "Best", "Type", "Prob"),
  center = TRUE,
  color = hcl.colors(101, "Blue-Red 3"),
  cluster_rows = TRUE,
  fontsize = 6,
  zlim = c(-4, 4),
  main = capture,
  cluster_cols = TRUE,
  column_annotation_colours = list(
    HTO2 = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$HTO2) + 1)[-1],
      levels(tmp2$HTO2)),
    Best = setNames(
      # NOTE: Skipping the first colour (white).
      Polychrome::glasbey.colors(nlevels(tmp2$Best) + 1)[-1],
      levels(tmp2$Best))))

# What are the 'others' --------------------------------------------------------

# After valid 13,15 pair, most common is 13,14,15 which could be doublets of
# (13,15) and (13, 14) or (13, 15) and (14, 15).
sort(table(grep("Mouse_HTO_13", grep("Mouse_HTO_15", tmp$HTO, value = TRUE), value = TRUE)))

table(lengths(strsplit(as.character(tmp$HTO[!tmp$Frequent]), ",")))
table(lengths(strsplit(as.character(tmp$HTO[tmp$Best == "multiplet" & tmp$HTO2 == "other"]), ",")))
