#'@title qd_sample
#'@param categories a vector of valid QuickDraw category
#'@param size a vector of number of rows to take from each category
#'@details qd_sample() downloads QuickDraw data from multiple categories and take a sample from each category
#'@return A tibble object that binds the sample data from all catgories.
#'@examples
#'qd_sample(c("octopus", "star"), 5)
#'@export

qd_sample <- function(categories, size){
  stopifnot(length(categories) %% length(size) == 0)
  stopifnot(categories %in% qd_categories())

  sample_one <- function(category, size){
    qd_read(category) %>% dplyr::sample_n(size)
  }

  purrr::map2_df(categories, size, sample_one)
}
