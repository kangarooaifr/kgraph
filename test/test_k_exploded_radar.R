# -- create fake data
data <- data.frame(category = c("Draft", "Plan", "In Work", "Done"),
                   nb = c(4,3, 5, 7),
                   progress = c(0, 0, 62, 100))


title <- "Title"

progress_line <- 4
progress_line_type <- "dashed"
progress_line_color <- "black"

progress_point <- c(2:5)
progress_point_color <- "black"
progress_point_size <- 3

width <- 0.25

color <- "#C06C84"
alpha <- c(0.2, 0.8)


plt <- k_exploded_radar(data, title = title, width = width, color = color, alpha = alpha,
                        progress_line = progress_line, progress_line_type = progress_line_type, progress_line_color = progress_line_color,
                        progress_point = progress_point, progress_point_size = progress_point_size, progress_point_color = progress_point_color)

print(plt)
