

foo <- data.frame(category = c("offset", "offset", "offset", "offset","offset",
                                "draft", "draft", "draft", "draft", "draft",
                                "planned", "planned", "planned", "planned", "planned",
                                "inwork", "inwork", "inwork", "inwork", "inwork",
                                "done", "done", "done", "done", "done"),
                   nb = c(0, 0, 0, 0, 0,
                          0, 4, 0, 0, 0,
                          4, 0, 3, 0, 0,
                          7, 0, 0, 5, 0,
                          12, 0, 0, 0, 7),
                   progress = c("xoffset", "draft", "planned", "inwork", "done",
                                "xoffset", "draft", "planned", "inwork", "done",
                                "xoffset", "draft", "planned", "inwork", "done",
                                "xoffset", "draft", "planned", "inwork", "done",
                                "xoffset", "draft", "planned", "inwork", "done"))


foo$category <- factor(foo$category, levels = unique(foo$category))


plt <- ggplot(foo, aes(x = category, y = nb)) +

  # -- build bar plot
  geom_col(aes(fill = progress), width = 0.5) +
  scale_fill_manual(values = c(alpha("#C06C84", 0.8),
                               alpha("#C06C84", 0.2),
                               alpha("#C06C84", 0.5),
                               alpha("#C06C84", 0.4),
                               "transparent")) +

  # Annotate point scaling
  annotate(
    x = 3,
    y = 2,
    label = paste("Draft\n",4),
    geom = "text",
    angle = 0,
    color = "black",
    size = 4) +

  annotate(
    x = 4,
    y = 5,
    label = paste("Planned\n",3),
    geom = "text",
    angle = 0,
    color = "black",
    size = 4) +

  annotate(
    x = 5,
    y = 9.5,
    label = paste("In Progress\n",5),
    geom = "text",
    angle = 0,
    color = "black",
    size = 4) +

  annotate(
    x = 6,
    y = 15,
    label = paste("Done\n", 7),
    geom = "text",
    angle = 0,
    color = "black",
    size = 4) +


  # -- add inwork progress line
  geom_segment(aes(x = 4, y = 7, xend = 4, yend = 12),
    linetype = "dashed",
    color = "black") +


  # -- add inwork progress point << factorize one line
  geom_point(aes(x = 2, y = 0), colour = "black", size = 3) +
  geom_point(aes(x = 3, y = 4), colour = "black", size = 3) +
  geom_point(aes(x = 4, y = 10), colour = "black", size = 3) +
  geom_point(aes(x = 5, y = 19), colour = "black", size = 3) +

  # -- make circular
  coord_polar(theta = "y") +

  # -- labels
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +

  # -- Remove color fill legend
  theme(legend.position = "None") +

  # -- Title
  labs(title = "Task Status")




print(plt)
