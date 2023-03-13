library(ggplot2)
library(ggpubr)

codedir <- getwd()
figdir <- file.path(codedir, "../figures")

mar <- 1

##################################################################
## Experienced utility independent of surprise

pre_x <- c('2/3', '1/3', '0', '1', ' 2/3 ', ' 1/3 ')
x   <- factor(pre_x, levels=pre_x)
y   <- c(.5, .5, .5, 1, 1, 1)
names <- c('neutral outcome', 'appetitive outcome')
grp <- factor(y, labels=names)

pdata <- data.frame(x, y, grp)

p1 <- ggplot(data=pdata, aes(x=x, y=y, fill=grp)) +
  geom_bar(stat="identity") +
  geom_hline(yintercept=.5, alpha=.15) +
  ylab("Expected Neural Signal") +
  xlab("Pr(Appetitive)") +
  scale_fill_manual(values=c("red", "skyblue")) +
  scale_y_continuous(breaks=unique(y), labels=c('0','1')) +
  theme_classic() +
  theme(legend.title = element_blank(),
        legend.position=c(.25,.9),
        plot.margin = margin(mar,mar,mar,mar, "cm"))


##################################################################
## Experienced utility modulated by surprise

pre_x <- c('2/3', '1/3', '0', '1', ' 2/3 ', ' 1/3 ')
x   <- factor(pre_x, levels=pre_x)
y   <- c(1/6, 2/6, 3/6, 4/6, 5/6, 6/6)
names <- c('neutral outcome', 'appetitive outcome')
grp <- factor(c(.5, .5, .5, 1, 1, 1), labels=names)

pdata <- data.frame(x, y, grp)

p2 <- ggplot(data=pdata, aes(x=x, y=y, fill=grp)) +
  geom_bar(stat="identity") +
  geom_hline(yintercept=.5, alpha=.15) +
  ylab("Expected Neural Signal") +
  xlab("Pr(Appetitive)") +
  scale_fill_manual(values=c("red", "skyblue")) +
  scale_y_continuous(breaks=y, labels=c('-2/3', '-1/3', '0', '1/3', '2/3', '1')) +
  theme_classic() +
  theme(legend.title = element_blank(),
        legend.position='none',
        plot.margin = margin(mar,mar,mar,mar, "cm"))


##################################################################
## Combine

final <- ggarrange(p1, p2,
                   labels = c("A", "B"),
                   ncol = 2)

ggsave(file.path(figdir,"fig_predictions.pdf"), final, width=8.5, height=4, units='in')

