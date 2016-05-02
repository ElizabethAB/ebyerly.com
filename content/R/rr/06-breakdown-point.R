good <- data.frame(x = c(-5:5, 6), y = 0)
bad <- data.frame(x = c(-4:4, 50), y = 0)

one <- ggplot(data = good, aes(x = x, y = y)) +
  geom_point(col = my_grey, size = 3) +
  geom_vline(xintercept = mean(good$x), col = my_orange, size = 2) +
  geom_vline(xintercept = median(good$x), linetype = 'twodash', col = my_blue,
             size = 2) +
  labs(x = '', y = '') +
  theme(axis.ticks = element_blank(), axis.text = element_blank())

two <- ggplot(data = bad, aes(x = x, y = y)) +
  geom_point(col = my_grey, size = 3) +
  geom_vline(xintercept = mean(bad$x), col = my_orange, size = 2) +
  geom_vline(xintercept = median(bad$x), linetype = 'twodash', col = my_blue,
             size = 2) +
  labs(x = '', y = '') +
  theme(axis.ticks = element_blank(), axis.text = element_blank())

together <- arrangeGrob(one, two, ncol = 1)

ggsave(file.path(output_Path, "rr-06-mean-v-median.png"), together,
       height = 2, width = 10)


