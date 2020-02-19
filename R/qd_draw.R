#' @title qd_draw
#' @param object A tibble object produced by qd_tidy()
#' @return An animation of the quick draw
#' @examples
#' apple <- qd_read("apple") %>% qd_tidy(1)
#' qd_draw(apple)
#' @import ggplot2

qd_draw <- function(object){

  object_to_plot <- object %>%
    dplyr::group_by(item) %>%
    dplyr::mutate(id = dplyr::row_number())

  object_to_plot %>%
    ggplot(aes(x = x, y = y, group = stroke)) +
    geom_line() +
    xlim(c(0, 256)) +
    ylim(c(0, 256))  +
    theme_void() +
    facet_wrap(vars(item)) +
    gganimate::transition_reveal(id)
}
