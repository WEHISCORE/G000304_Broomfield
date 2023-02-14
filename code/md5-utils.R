#' @object R object to serialize.
#' @file Absolute path to the name of the file where the R object is save to.
#' @param md5_file Path to the md5 file. If `NULL` uses the default path
#'   of the form `here("data/md5/<basename(file)>.md5")`.
#' @param ... Additional arguments passed to `saveRDS()`.
#'
#' @note This function assumes (and doesn't check) that **here** is used to
#'   manage the project's files.
saveRDSWithMD5 <- function(object, file, md5_file = NULL, ...) {
  saveRDS(object = object, file = file, ...)
  md5_df <- data.frame(
    # NOTE: Have to unname() because path recorded in `md5_file` is relative to
    #       the project root whereas that computed used `tools::md5sum()` uses
    #       the absolute path.
    md5 = unname(tools::md5sum(file)),
    # NOTE: Remove the here-prefix to get the local (i.e. relative to the
    #       project root) path to the file.
    file = sub(file.path(here::here(), ""), "", file))
  if (is.null(md5_file)) {
    md5_file <- here::here("data", "md5", paste0(basename(file), ".md5"))
  }
  write.table(
    x = md5_df,
    file = md5_file,
    quote = FALSE,
    sep = " ",
    row.names = FALSE,
    col.names = FALSE)
}

#' @param file Absolute path to the name of the file where the R object is read
#'   from.
#' @param md5_file Path to the md5 file. If `NULL` uses the default path
#'   of the form `here("data/md5/<basename(file)>.md5")`.
#'
#' @note This function assumes (and doesn't check) that **here** is used to
#'   manage the project's files.
readRDSWithMD5 <- function(file, md5_file = NULL) {
  if (is.null(md5_file)) {
    md5_file <- here::here("data", "md5", paste0(basename(file), ".md5"))
  }
  stopifnot(file.exists(md5_file))
  md5_df <- read.table(md5_file)
  md5 <- md5_df[[1]]
  # NOTE: Have to unname() because path recorded in `md5` is relative to the
  #       project root whereas that computed used `tools::md5sum()` uses the
  #       absolute path.
  tools_md5 <- unname(tools::md5sum(file))
  if (!identical(md5, tools_md5)) {
    stop(
      "MD5sum mismatch for ", sQuote(file), ".\n",
      "Please check you have the latest version of this file.\n")
  }
  readRDS(file)
}
