setwd("C:/Users/elizabeth.byerly/Documents/ebyerly.com")

library(ggplot2)

freq <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut))
ggsave("img/data-intake-basic-freq.png", freq, width = 6, height = 2.5)

disp <- ggplot(diamonds) +
  geom_density(aes(x = depth), fill = "#126180") +
  geom_vline(aes(xintercept = mean(depth)))
ggsave("img/data-intake-basic-disp.png", disp, width = 6, height = 2.5)

jfreq <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = color), position = "dodge")
ggsave("img/data-intake-basic-jfreq.png", jfreq, width = 6, height = 2.5)

jdisp <- ggplot(diamonds) +
  geom_density(aes(x = depth, fill = cut), alpha = .7)
ggsave("img/data-intake-basic-jdisp.png", jdisp, width = 6, height = 2.5)

pnt <- ggplot(diamonds) +
  geom_point(aes(x = z, y = price, color = cut), alpha = .7)
ggsave("img/data-intake-basic-pnt.png", pnt, width = 6, height = 2.5)


md <- data.frame(diamonds)

set.seed(20160408)
md[2:ncol(md)] <- lapply(md[2:ncol(md)], function(x) {
  x[sample(1:length(x))[1:round(length(x)/10)]] <- NA
  x
})

knitr::kable(md[1:10,])

print(xtable::xtable(md[1:5,]), type = "html",
      include.rownames = FALSE,
      html.table.attributes='border="1" align="center" bgcolor="#e0e0e0"')
