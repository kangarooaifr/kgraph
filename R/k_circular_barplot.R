


library(dplyr)
library(ggplot2)
library(stringr)
#
# # download and cast data
# hike_data <- readr::read_rds(file = "~/Work/R/Library/Packages/kgraph/R/hike_data.rds")
# hike_data$region <- as.factor(word(hike_data$location, 1, sep = " -- "))
# hike_data$length_num <- as.numeric(sapply(strsplit(hike_data$length, " "), "[[", 1))
#
# # prepare data
# plot_df <- hike_data %>%
#   group_by(region) %>%
#   summarise(
#     sum_length = sum(length_num),
#     mean_gain = mean(as.numeric(gain)),
#     n = n()
#   ) %>%
#   mutate(mean_gain = round(mean_gain, digits = 0))


foo <<- data.frame(category = c("draft", "planned", "inwork", "done"),
                      nb = c(400, 300, 1000, 1500),
                      mean = c(0, 1500, 1790, 2789),
                      progress = c(0, 0, 53, 86))




k_circular_barplot <- function(data){

  # check missing data
  if(is.null(data))
    stop("\n  data is NULL", call. = TRUE)


  # -------------------------------------------------
  title = "Task status"
  subtitle = "This Visualisation shows the amout of tasks per status."


  font_family <- "Calibri"

  # -------------------------------------------------

  # -- build plot
  plt <- ggplot(data) +

    # Make custom grid
    geom_hline(
      aes(yintercept = y),
      data.frame(y = c(0:3) * 1000), # <<< --- SCALE
      color = "lightgrey") +


    # Add bars to represent progress
    geom_col(
      aes(
        x = reorder(category, progress),
        y = nb,
        fill = progress
      ),
      position = "dodge2",
      show.legend = TRUE,
      alpha = .9
    ) +

    # Add dots to represent the mean
    geom_point(
      aes(
        x = category,
        y = mean
      ),
      size = 3,
      color = "gray12"
    ) +

    # Lollipop shaft for mean gain per region
    geom_segment(
      aes(
        x = category,
        y = 0,
        xend = category,
        yend = 3000 # <<< --- SCALE
      ),
      linetype = "dashed",
      color = "gray12"
    )


    # Make it circular!
    plt <- plt + coord_polar(theta = "y")


    # Annotate
    plt <- plt +

      # Annotate point scaling
      # annotate(
      #   x = 11,
      #   y = 3150,
      #   label = "Cummulative Length [FT]",
      #   geom = "text",
      #   angle = 23,
      #   color = "gray12",
      #   size = 2.5,
      #   family = font_family
      # ) +

      # Annotate custom scale inside plot
      annotate(
        x = 11.7,
        y = 1100, # <<< --- SCALE
        label = "30%",
        geom = "text",
        color = "gray12",
        family = font_family
      ) +

      annotate(
        x = 11.7,
        y = 2100, # <<< --- SCALE
        label = "60%",
        geom = "text",
        color = "gray12",
        family = font_family
      ) +

      annotate(
        x = 11.7,
        y =3100, # <<< --- SCALE
        label = "100%",
        geom = "text",
        color = "gray12",
        family = font_family
      ) +

      # Scale y axis so bars don't start in the center
      scale_y_continuous(
        limits = c(-1500, 3500), # <<< --- SCALE
        expand = c(0, 0),
        breaks = c(0, 1000, 2000, 3000) # <<< --- SCALE
      ) +

      # New fill and legend title for number of tracks per region
      scale_fill_gradientn(
        "Progress Scale",
        colours = c( "#6C5B7B","#C06C84","#F67280","#F8B195")
      ) +

      # Make the guide for the fill discrete
      guides(
        fill = guide_colorsteps(
          barwidth = 15, barheight = .5, title.position = "top", title.hjust = .5
        )
      ) +

      theme(
        # Remove axis ticks and text
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_blank(),
        # Use gray text for the region names
        axis.text.x = element_text(color = "gray12", size = 12),
        # Move the legend to the bottom
        legend.position = "bottom",
      )


    plt <- plt +

      # Add labels
      labs(
        title = title,
        subtitle = subtitle,
        caption = "k_circular_barplot") +

      # Customize general theme
      theme(

        # Set default color and font family for the text
        text = element_text(color = "gray12", family = "Calibri"),

        # Customize the text in the title, subtitle, and caption
        plot.title = element_text(face = "bold", size = 25, hjust = 0.05),
        plot.subtitle = element_text(size = 14, hjust = 0.05),
        plot.caption = element_text(size = 10, hjust = .5),

        # Make the background white and remove extra grid lines
        panel.background = element_rect(fill = "white", color = "white"),
        panel.grid = element_blank(),
        panel.grid.major.x = element_blank()
      )
    # Use `ggsave("plot.png", plt,width=9, height=12.6)` to save it as in the output
    plt



  plt


}

k_circular_barplot(plot_df)


