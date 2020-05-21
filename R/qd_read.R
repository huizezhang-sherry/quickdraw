#'@title Load a QuickDraw category as an R object
#'@param category a valid QuickDraw category
#'@param verbose avoid qd_download() message if verbose = TRUE
#'@details
#' * `qd_read()`: loads a QuickDraw ndjson file as a [tibble::tibble()],
#'  containing 6 columns: word, key_id, countrycode, timestamp, recognized,
#'  drawing.
#' * `qd_read_bitmap()`: loads a QuickDraw npy file as an ordinary R matrix,
#'  requires the `reticulate` package, with python and numpy installed. Each
#'  row of the matrix represents a 28 by 28 bitmap image, so the total dimension
#'  is n_images * 784.
#'@examples
#'qd_read("apple")
#'@export
#'@rdname qd_read
qd_read <- function(category,verbose = TRUE){

  path <- if (verbose) {
    qd_download(category)
  } else {
    suppressMessages(qd_download(category))
  }

  tibble::as_tibble(corpus::read_ndjson(path))
}

#'@export
#'@rdname qd_read
qd_read_bitmap <- function(category) {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    stop("reticulate required to read npy bitmaps")
  }

  np <- reticulate::import("numpy")
  path <- qd_download_bitmap(category)
  np$load(path)
}

