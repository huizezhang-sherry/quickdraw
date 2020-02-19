#' @title valid quick draw category
#' @return vector of valid quick draw category
#' @details The source is: [raw_data](https://raw.githubusercontent.com/googlecreativelab/quickdraw-dataset/master/categories.txt)
#' @export
qd_categories <- function() {
  readLines(system.file("extdata", "categories.txt", package = "quickdraw"))
}
