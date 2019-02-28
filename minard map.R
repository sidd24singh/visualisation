library(HistData)
data(Minard.troops)
data(Minard.cities)
data(Minard.temp)
library(ggplot2)
library(scales)
library(gridExtra)
plot_troops <- ggplot(Minard.troops, aes(long, lat)) +
  geom_path(aes(size = survivors, colour = direction, group = group),
            lineend = "round", linejoin = "round")
plot_cities <- geom_text(aes(label = city), size = 4, data = Minard.cities)
breaks <- c(1, 2, 3) * 10^5 
plot_minard <- plot_troops + plot_cities +
  scale_size("Survivors", range = c(1, 10), 
             breaks = breaks, labels = scales::comma(breaks)) +
  scale_color_manual("Direction", 
                     values = c("yellow", "blue"), 
                     labels=c("Advance", "Retreat")) +
  coord_cartesian(xlim = c(24, 38)) +
  xlab(NULL) + 
  ylab("Latitude") + 
  ggtitle("Napoleon's March on Moscow") +
  theme_bw() +
  theme(legend.position=c(.8, .2), legend.box="horizontal")
plot_temp <- ggplot(Minard.temp, aes(long, temp)) +
  geom_path(color="blue", size=1.5) +
  geom_point(size=2) +
  geom_text(aes(label=date)) +
  xlab("Longitude") + ylab("Temperature") +
  coord_cartesian(xlim = c(24, 38)) + 
  theme_bw()
grid.arrange(plot_minard, plot_temp, nrow=2, heights=c(3,1))