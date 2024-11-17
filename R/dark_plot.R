

library(ggplot2)
library(ggfx)
library(magrittr)

data <- data.frame(x = c(1,2,3,4,5),
                     y = c(100,50,200,300,75))

dark_plot <- function(data){

  # -- init
  data %>%
    ggplot() +

    # -- point
    geom_point(
      aes(
        x = x,
        y = y),
      colour = "pink") +

    with_outer_glow(
      geom_smooth(
        aes(x = x, y = y),
        colour = "pink",
        size = 0.5),
      colour = "pink", sigma = 3, expand = 0) +

    labs(x = NULL, y = NULL) +

    # -- theme
    theme(

      panel.background = element_rect(fill = "grey20"),
      plot.background = element_rect(fill = "grey20"),
      panel.grid = element_line(colour = NA),

      axis.text = element_text(colour = "pink"))

}
