

#' Exploded Radar Plot
#'
#' @param data a data.frame of the data to plot, with columns (category, nb, progress). Other columns will be ignored.
#' @param title a label to set as title of the plot. NULL will display no title (DEFAULT).
#' @param width the desired width for the radar area. It will be used as an offset from the center line, so each bar will be 2*width thick. DEFAULT = 0.25
#' @param color the reference color to fill the sector. DEFAULT = "#C06C84"
#' @param alpha a vector of length 2 c(min, max). Will be used to build a sequence of @color passed to scale_fill_manual. DEFAULT = c(0.2, 0.8).
#' @param progress_line a vector to define which sector should have a progress line in it. Will be used to subset @data columns. DEFAULT = NULL.
#' @param progress_line_type the desired type of line. DEFAULT = "dashed".
#' @param progress_line_color the desired color of line. DEFAULT = "black".
#' @param progress_point a vector to define which sector should have a progress point in it. Will be used to subset @data columns. DEFAULT = NULL.
#' @param progress_point_size the desired size for the point. DEFAULT = 3.
#' @param progress_point_color the desired color for the point. DEFAULT = "black.
#'
#' @return a plot (from @ggplot function)
#' @export k_exploded_radar
#'
#' @examples

k_exploded_radar <- function(data, title = NULL, width = 0.25, color = "#C06C84", alpha = c(0.2, 0.8),
                             progress_line = NULL, progress_line_type = "dashed", progress_line_color = "black",
                             progress_point = NULL, progress_point_size = 3, progress_point_color = "black"){

  # ------------------------------------
  # Arguments
  # ------------------------------------
  alpha_min <- alpha[1]
  alpha_max <- alpha[2]


  # ------------------------------------
  # Prepare data
  # ------------------------------------

  # -- add fake raw to create radar (x) offset
  data <- rbind(data.frame(category = "offset", nb = 0, progress = 0), data)

  # -- use factor to avoid reordering
  data$category <- factor(data$category, levels = unique(data$category))

  # -- compute ymin/ymax for rectangles (to create offset)
  data$ymax <- cumsum(data$nb)
  data$ymin <- data$ymax - data$nb


  # ------------------------------------
  # Build plot
  # ------------------------------------

  # -- build plot
  plt <- ggplot() +


    # -- draw rectangle base plot
    geom_rect(data = data, aes(xmin = as.numeric(category) - width, xmax = as.numeric(category) + width, ymin = ymin, ymax = ymax, fill = category)) +


    # -- add color scale
    scale_fill_manual(values =  c(alpha(color, seq(from = alpha_min, to = alpha_max, length.out = dim(data)[1])))) +


    # -- add labels (-1 to remove offset label) (better with short names..)
    geom_text(data = data[-1, ], aes(x = as.numeric(category) + 1, y = (ymin+ymax) / 2, label = paste(category, ":", nb))) +


    # -- add progress line
    geom_segment(data = data[progress_line, ], aes(x = as.numeric(category), y = ymin, xend = as.numeric(category), yend = ymax),
                 linetype = progress_line_type,
                 color = progress_line_color) +


    # -- add progress point
    geom_point(data = data[progress_point, ], aes(x = as.numeric(category), y = ymin+(ymax-ymin)/100*progress), colour = progress_point_color, size = progress_point_size) +

    # -- make circular!
    coord_polar(theta = "y") +

    # -- remove axis labels
    theme(axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank()) +

    # -- Remove color fill legend
    theme(legend.position = "None") +

    # -- Set title & center (NULL will be ignored)
    labs(title = title) +
    theme(
      plot.title = element_text(hjust = 0.5))


}

