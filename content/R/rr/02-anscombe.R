data(anscombe)

myscombe <- data.frame(y = c(anscombe$y1, anscombe$y2,
                             anscombe$y3, anscombe$y4),
                       x = c(anscombe$x1, anscombe$x2,
                             anscombe$x3, anscombe$x4),
                       set = c(rep(1, nrow(anscombe)), rep(2, nrow(anscombe)),
                               rep(3, nrow(anscombe)), rep(4, nrow(anscombe))))

first_ppt <- ggplot(myscombe[myscombe$set == 3,], aes(x=x, y=y)) +
  geom_point(size=4, color = my_orange, alpha = 0.7) +
  geom_smooth(method="lm", fill=NA, fullrange=TRUE,
              col = my_grey, alpha = 0.1) +
  stat_smooth(method="rlm", formula = y ~ x, fill=NA,
              fullrange=TRUE, size=1, col = my_blue) +
  scale_x_continuous(limits=c(0,20), expand=c(0,0)) +
  scale_y_continuous(limits=c(0,15), expand=c(0,0)) +
  labs(x = '', y = '') +
  theme(axis.ticks = element_blank(),
        text = element_blank())

ggsave(file.path(output_Path, "rr-02-example-v-linear.png"),
       first_ppt, width = 5, height = 5)


third_ppt <- ggplot(myscombe, aes(x=x, y=y)) +
  geom_point(size=4, color = my_orange, alpha = 0.7) +
  geom_smooth(method="lm", fill=NA, fullrange=TRUE,
              col = my_grey, alpha = 0.1) +
  stat_smooth(method="lmrob", formula = y ~ x, fill=NA,
              fullrange=TRUE, size=1, col = my_blue) +
  scale_x_continuous(limits=c(0,20), expand=c(0,0)) +
  scale_y_continuous(limits=c(0,15), expand=c(0,0)) +
  labs(x = '', y = '') +
  theme(axis.ticks = element_blank(), axis.text = element_blank()) +
  facet_wrap(~ set) +
  theme(axis.ticks = element_blank(),
        text = element_blank())

ggsave(file.path(output_Path, "rr-02-anscombes-quartet.png"),
       third_ppt, width = 12, height = 5)
