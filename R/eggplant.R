

# -- colors
background_color <- "#342c39"

color_area <- "#50425b"

color_pink <- "#ec54cb"
color_orange <- "#ec7113"
color_yellow <- "#fff165"


# -- dataset
library(readr)
test <- read_csv("E:/Datasets/insee_defaillance_entreprises_2024_08.csv")
names(test) <- c("x", "y")
test$x <- paste0("01/", test$x)
test$x <- as.Date(test$x, format = "%d/%m/%Y")

# -- plot
library(ggplot2)
library(ggpattern)
library(magrittr)

eggplant_smooth <- function(data){

  # -- select max / mins
  min_max <- rbind(head(data[order(data$y, decreasing = T), ], n = 2),
                   head(data[order(data$y), ], n = 2))

  # -- init
  data %>%
    ggplot() +

    # -- background area
    # geom_area(
    #   aes(x = x,
    #       y = y,
    #       alpha = y),
    #   fill = color_area) +

    # -- gradient background area (slow!)
    geom_area_pattern(
      aes(x = x,
          y = y),
      pattern = "gradient",
      fill = background_color,
      pattern_fill  = background_color,
      pattern_fill2 = color_area) +

    # -- labels
    geom_point(
      data = min_max,
      aes(x = x,
          y = y),
      colour = "grey",
      size = 0.5) +

    # -- labels
    geom_text(
      data = min_max,
      aes(x = x,
          y = y,
          label = paste0(round(y), "\n", unlist(strsplit(as.character(x), "-01")))),
      colour = "grey",
      hjust = 0,
      vjust = 1,
      nudge_x = 100,
      size = 2.5) +

    # -- END BACKGROUND --------------------------------------------------------

    # -- shadow
    ggfx::with_outer_glow(
      geom_smooth(
        aes(x = x,
            y = y),
        size = 3,
        colour = "black",
        alpha = 0.3,
        se = FALSE),
      colour = "black", sigma = 5, expand = 0) +

    # -- outer glow
    ggfx::with_outer_glow(
      geom_smooth(
        aes(x = x,
            y = y),
        size = 2,
        colour = color_yellow,
        se = FALSE),
      colour = color_yellow, sigma = 2, expand = 0) +

    # -- curve
    geom_smooth(
      aes(x = x,
          y = y,
          color = ..y..),
      size = 1.5,
      se = FALSE) +

    # -- gradient
    scale_colour_gradient(low = color_pink, high = color_orange) +

    # -- END SMOOTH CURVE ------------------------------------------------------

    # -- title
    geom_text(
      data = data.frame(x = min(data$x),
                        y = max(data$y),
                        label = "Defaillances d'entreprises"),
      aes(x = x,
          y = y,
          label = label),
      hjust = 0,
      vjust = 1,
      family = "Grandview",
      fontface = "bold",
      size = 8,
      colour = "grey") +

    # -- sub title
    geom_text(
        data = data.frame(x = min(data$x),
                          y = max(data$y),
                          label = "Données mensuelles (2000-2024)"),
        aes(x = x,
            y = y,
            label = label),
        hjust = 0,
        vjust = 1,
        nudge_y = -250,
        family = "Grandview",
        fontface = "italic",
        size = 4,
        colour = "grey") +

    # -- source
    geom_text(
      data = data.frame(x = min(data$x),
                        y = max(data$y),
                        label = "Source: INSEE"),
      aes(x = x,
          y = y,
          label = label),
      hjust = 0,
      vjust = 1,
      nudge_y = -500,
      family = "Grandview",
      size = 3,
      colour = "grey") +

    # -- END TITLE -------------------------------------------------------------

    # -- axis
    labs(x = NULL, y = NULL) +
    scale_x_date(breaks = "2 years", date_labels = "%Y") +

    # -- theme
    theme(

      legend.position = "none",

      panel.background = element_rect(fill = background_color),
      plot.background = element_rect(fill = background_color),
      panel.grid = element_line(colour = NA),

      axis.text = element_text(colour = "grey"))

}
