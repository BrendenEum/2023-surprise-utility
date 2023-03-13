library(ggplot2)

neutral_color <- "white"
reward_color  <- "green3"

size.px <- 380 # height of the lingerie stimuli
margin <- -.38

# unlikely good  #################################################

slices <- c(1, 2)
colors <- factor(c(1,2))
pdata <- data.frame(
  x=colors,
  y=slices
)

p.stimulus <- ggplot(data=pdata, aes(x="", y=y, fill=colors)) +
  
  geom_col(color = "black") +
  coord_polar(theta="y") +
  scale_fill_manual(values=c("1"=reward_color,"2"=neutral_color)) +
  theme_void() +
  theme(
    legend.position = "none",
    plot.background = element_rect(fill = "white", color = "white"),
    panel.background = element_rect(color = NA),
    plot.margin = unit(c(margin,margin,margin,margin),"cm")
  )

plot(p.stimulus)

ggsave(
  filename="pie13.png", 
  plot=p.stimulus,
  width=size.px,
  height=size.px,
  units="px"
)

# likely good    #################################################

p.stimulus <- ggplot(data=pdata, aes(x="", y=y, fill=colors)) +
  
  geom_col(color = "black") +
  coord_polar(theta="y") +
  scale_fill_manual(values=c("1"=neutral_color,"2"=reward_color)) +
  theme_void() +
  theme(
    legend.position = "none",
    plot.background = element_rect(fill = "white", color = "white"),
    panel.background = element_rect(color = NA),
    plot.margin = unit(c(margin,margin,margin,margin),"cm")
  )

plot(p.stimulus)

ggsave(
  filename="pie23.png", 
  plot=p.stimulus,
  width=size.px,
  height=size.px,
  units="px"
)

# certain good   #################################################

slices <- c(3, 0)
colors <- factor(c(1,2))
pdata <- data.frame(
  x=colors,
  y=slices
)

p.stimulus <- ggplot(data=pdata, aes(x="", y=y, fill=colors)) +
  
  geom_col(color = "black") +
  coord_polar(theta="y") +
  scale_fill_manual(values=c("1"=reward_color,"2"=neutral_color)) +
  theme_void() +
  theme(
    legend.position = "none",
    plot.background = element_rect(fill = "white", color = "white"),
    panel.background = element_rect(color = NA),
    plot.margin = unit(c(margin,margin,margin,margin),"cm")
  )

plot(p.stimulus)

ggsave(
  filename="pie1.png", 
  plot=p.stimulus,
  width=size.px,
  height=size.px,
  units="px"
)

# certain not good   #################################################

p.stimulus <- ggplot(data=pdata, aes(x="", y=y, fill=colors)) +
  
  geom_col(color = "black") +
  coord_polar(theta="y") +
  scale_fill_manual(values=c("1"=neutral_color,"2"=reward_color)) +
  theme_void() +
  theme(
    legend.position = "none",
    plot.background = element_rect(fill = "white", color = "white"),
    panel.background = element_rect(color = NA),
    plot.margin = unit(c(margin,margin,margin,margin),"cm")
  )

plot(p.stimulus)

ggsave(
  filename="pie0.png", 
  plot=p.stimulus,
  width=size.px,
  height=size.px,
  units="px"
)