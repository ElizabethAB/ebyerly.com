y <- 1:20
x <- y*4*abs(rnorm(20, 1, .05))

outlier <- data.frame(x = c(x, 20), y = c(y, -10))
leverage <- data.frame(x = c(x, 120), y = c(y, 30))
influence <- data.frame(x = c(x, 120), y = c(y, -10))

lm_plot <- function(df) {
  ggplot(data = df, aes(x = x, y = y)) +
    geom_point(size=4, color = my_orange, alpha = 0.7) +
    geom_smooth(method="lm", fill=NA, fullrange=TRUE,
                size=1.5, col = my_blue) +
    labs(x = '', y = '') +
    theme(axis.ticks = element_blank(), axis.text = element_blank())
}

mm_plot <- function(df) {
  ggplot(data = df, aes(x = x, y = y)) +
    geom_point(size=4, color = my_orange, alpha = 0.7) +
    stat_smooth(method="lmrob", formula = y ~ x, fill=NA,
                fullrange=TRUE, size=1.5, col = my_blue) +
    labs(x = '', y = '') +
    theme(axis.ticks = element_blank(), axis.text = element_blank())
}


points_names <- arrangeGrob(textGrob("Outlier", gp = gpar(fontface = 'bold')),
                            textGrob("Leverage", gp = gpar(fontface = 'bold')),
                            textGrob("Influence", gp = gpar(fontface = 'bold')),
                            ncol = 3)
lm_plots <- arrangeGrob(lm_plot(outlier), lm_plot(leverage), lm_plot(influence),
                        ncol = 3)

lm_final_plot <- arrangeGrob(points_names, lm_plots,
                             nrow = 2, heights = c(1,10))

ggsave(file.path(output_Path, "rr-04-lm-plots.png"),
       lm_final_plot, height = 4, width = 9.5, dpi = 600)


mm_plots <- arrangeGrob(mm_plot(outlier), mm_plot(leverage), mm_plot(influence),
                        ncol = 3)
mm_final_plot <- arrangeGrob(points_names, mm_plots,
                             nrow = 2, heights = c(1,10))

ggsave(file.path(output_Path, "rr-04-mm-plots.png"),
       mm_final_plot, height = 4, width = 9.5, dpi = 600)


comparison_plot <- arrangeGrob(points_names, lm_plots, mm_plots, nrow = 3,
                               heights = c(1,5,5))
ggsave(file.path(output_Path, "rr-04-comparison-plots.png"),
       comparison_plot, height = 5, width = 12, dpi = 600)
