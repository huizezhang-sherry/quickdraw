#'@title qd_raster
#'@param data a tibble object resulted from qd_tidy()
#'@return a tibble object with x and y coordinate of the raster matrix
#'@examples
#'qd_read("apple") %>% qd_tidy(1) %>% qd_raster()
#'@export qd_raster
qd_raster <- function(data){

  id <- rlang::sym("id")
  x <- rlang::sym("x")
  y <- rlang::sym("y")

  #browser()
  second <- data %>% dplyr::mutate(id = dplyr::row_number())

  dplyr::bind_rows(second %>% dplyr::slice(-1), second) %>%
    dplyr::arrange(!!id) %>%
    dplyr::mutate(id = dplyr::lead(!!id)) %>%
    dplyr::slice(-dplyr::n()) %>%
    dplyr::group_by(!!id) %>%
    tidyr::nest() %>%
    dplyr::mutate(interp = purrr::map(data, interp)) %>%
    tidyr::unnest(interp) %>%
    dplyr::select(!!x, !!y) %>%
    dplyr::mutate(x = round(!!x), y = round(!!y)) %>%
    dplyr::ungroup() %>%
    dplyr::select(-!!id)

}


interp <- function(data){
  #browser()
  x <- data$x
  y <- data$y

  x_diff <- abs(diff(data$x))
  y_diff <- abs(diff(data$y))

  step <- max(x_diff, y_diff)

  if(x_diff == 0 & y_diff == 0){
    dt <- data
  }else if(y_diff == 0){
    dt <- tibble::tibble(x = data$y[[1]], y = seq(data$x[1], data$x[2]))
  } else if (x_diff == 0){
    dt <- tibble::tibble(x = data$x[[1]], y = seq(data$y[1], data$y[2]))
  }else{
    interp <- stats::approx(x, y, n = step)
    dt <- tibble::as.tibble(matrix(c(interp$x, interp$y), ncol = 2, nrow = step))
    colnames(dt) <- c("x","y")}

  dt
}
