

library(tidyr)
library(ggplot2)

# this is a rose plot
# Beautiful but takes a while to print !!!!!!!!!


plt <- seq(-3,3,by=.01) %>%
  expand.grid(x=., y=.) %>%
  ggplot(aes(x=(1-x-sin(y^2)), y=(1+y-cos(x^2)))) +
  geom_point(alpha=.05, shape=20, size=0)+
  theme_void()+
  coord_polar()

