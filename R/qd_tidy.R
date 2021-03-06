#'@title qd_tidy
#'@param object A tibble object produced by qd_read()
#'@param item The row number of drawing to tidy
#'@return A tibble object with the x and y coordinate of each stroke
#'@examples
#'apple <- qd_read("apple")
#'qd_tidy(apple,1)
#'@export

qd_tidy <- function(object, item = 1:nrow(object)){
  stopifnot("drawing" %in% colnames(object))

  tidy_single <- function(id){
    purrr::map_dfr(object$drawing[[id]], function(id){
      tibble::tibble(x = id[[1]],
                     y = 255 - id[[2]])
    },.id = "stroke") %>%
      dplyr::mutate(word = object$word[id],
                    countrycode = object$countrycode[id],
                    timestamp = object$timestamp[id],
                    recognised = object$recognized[id],
                    key_id = object$key_id[id])

  }

  if(length(item) > 100) message("QuickDraw could be slow when loading large number of draws")
  purrr::map_dfr(item, tidy_single, .id = "item")

}
