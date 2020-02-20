#'@title qd_download download QuickDraw files
#'@param category a valid QuickDraw category
#'@details 
#' * `qd_download()`: retrieves and caches drawings in ndjson file
#' * `qd_download_bitmap()`: retrieves and caches drawings in numpy bitmap format. 
#'  
#'@return A character vector containing 
#'@examples
#'qd_download("apple")
#'@export
#'@rdname qd_download
qd_download <- function(category){

  # validation check

  stopifnot(category %in% qd_categories())
  stopifnot(length(category) == 1)

  cache <- qd_cache()

  name <- paste0(category, ".ndjson")
  outfile <- file.path(cache, name)

  if (file.exists(outfile)) {
    message("QuickDraw file: ", name, " has been downloaded already!")
  } else {
    message("Downloading ", name,  " with cloudml")
    url <- paste0("gs://quickdraw_dataset/full/simplified/", name)
    cloudml::gs_copy(url, cache)
  }

  return(outfile)


}
#'@rdname qd_download
#'@export
qd_download_bitmap <- function(category) {
  
  stopifnot(category %in% qd_categories())
  stopifnot(length(category) == 1)
  
  cache <- qd_cache()
  
  name <- paste0(category, ".npy")
  outfile <- file.path(cache, name)
  
  if (file.exists(outfile)) {
    message("QuickDraw bitmap file: ", name, " has been downloaded already!")
  } else {
    message("Downloading ", name,  " with cloudml")
    url <- paste0("gs://quickdraw_dataset/full/numpy_bitmap/", name)
    cloudml::gs_copy(url, cache)
  }
  return(outfile)
}

qd_cache <- function() {
  cache_path <- file.path(Sys.getenv("HOME"), ".quickdraw")
  if (!dir.exists(cache_path)) dir.create(cache_path)
  cache_path
}

