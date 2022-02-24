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


plot_df <- data.frame(category = c("draft", "planned", "inwork", "done"),
                      nb = c(400, 300, 1000, 1500),
                      mean = c(0, 1500, 1790, 2789),
                      progress = c(0, 0, 53, 86))

print(k_circular_barplot(plot_df))
