x1<-cbind(1,rnorm(100,0,5))
x2<-cbind(1,rnorm(100,0,5))
b1<-c(-3,2)
b2<-c(4,-2)
y1<-x1%*%b1+rnorm(100)
y2<-x2%*%b2+rnorm(100)
x<-rbind(x1,x2)
y<-c(y1,y2)

tst <- data.frame(x = x[,2], y = y)

tst_plot <- ggplot(data = tst, aes(x = x, y = y)) +
  geom_point(size=4, color = my_orange, alpha = 0.7) +
  geom_smooth(method="lm", fill=NA, fullrange=TRUE,
              col = my_grey, alpha = 0.1) +
  stat_smooth(method = "lmrob", formula = y ~ x, fill=NA,
              fullrange=TRUE, size=1, col = my_blue) +
  labs(x = '', y = '') +
  theme(axis.ticks = element_blank(), text = element_blank())

ggsave(file.path(output_Path, "rr-07-multiple-relationships.png"),
       tst_plot, width = 12, height = 5)
