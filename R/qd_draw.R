#' @title qd_draw
#' @param object A tibble object produced by qd_tidy()
#' @param animate An option to display the QuickDraw in animation
#' @return An animation of the quick draw
#' @examples
#' apple <- qd_read("apple") %>% qd_tidy(1)
#' qd_draw(apple)
#' @import ggplot2
#' @importFrom rlang sym "!!"
#' @export

qd_draw <- function(object, animate = FALSE){

  item <- rlang::sym("item")
  stroke <- rlang::sym("stroke")
  id <- rlang::sym("id")
  x <- rlang::sym("x")
  y <- rlang::sym("y")

  object_to_plot <- object %>%
    dplyr::group_by(!!item) %>%
    dplyr::mutate(id = dplyr::row_number())

  plot <- object_to_plot %>%
    ggplot(aes(x = !!x, y = !!y, group = !!stroke)) +
    geom_path() +
    xlim(c(0, 255)) +
    ylim(c(0, 255))  +
    theme_void() +
    facet_wrap(vars(!!item)) +
    theme(strip.text = element_blank())

  if(animate){
    plot <- plot + gganimate::transition_reveal(!!id)
  }

  plot
}
