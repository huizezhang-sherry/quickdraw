qd_download <- function(category){

  # validation check
  stopifnot(category %in% categories)
  stopifnot(length(category) == 1)

  cache <- qd_cache()

  name <- paste0(category, ".ndjson")
  outfile <- file.path(cache, name)

  if (file.exists(outfile)) {
    message("QuickDraw file:", name, " already exists!")
  } else {
    message("Downloading ndjson with cloudml")
    url <- paste0("gs://quickdraw_dataset/full/simplified/", name)
    cloudml::gs_copy(url, cache)
  }

  return(outfile)


}

qd_cache <- function() {
  cache_path <- file.path(Sys.getenv("HOME"), ".quickdraw")
  if (!dir.exists(cache_path)) dir.create(cache_path)
  cache_path
}
