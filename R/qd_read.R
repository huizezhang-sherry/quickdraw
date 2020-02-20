#'@title qd_read
#'@param category a valid QuickDraw category
#'@details Read in the QuickDraw ndjson file downloaded by qd_download()
#'@return A tibble object contains 6 columns: word, countrycode, timestamp, recognized, key_id and drawing.
#'@examples
#'qd_read("apple")
#'@export

qd_read <- function(category,verbose = TRUE){


  path <- if (verbose) {
    qd_download(category)
  } else {
    suppressMessages(qd_download(category))
  }

  tibble::as.tibble(corpus::read_ndjson(path))
}

qd_read_bitmap <- function(category) {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    stop("reticulate required to read npy bitmaps")
  }
  
  np <- reticulate::import("numpy")
  path <- qd_download_bitmap(category)
  np$load(path)
}

