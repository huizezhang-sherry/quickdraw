qd_read <- function(category){
  path <- qd_download(category)

  tibble::as.tibble(corpus::read_ndjson(path))
}
