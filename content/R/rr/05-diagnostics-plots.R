crime <- read.csv("crime.csv")
tmp <- diagnosticsPlot(crime, "crime ~ poverty + single", .9, dot_size = 3,
                       overall_title =
                         "Poverty and Single Parent Population Predicting Crime")

ggsave(file.path(output_Path, "rr-05-crime-plot.png"), tmp[["Plot"]],
       height = 5.5, width = 12)


fairfax <- read.csv("fairfax.csv")
fairfax$lgPrice <- log(fairfax$Price)
fairfax$Age <- fairfax$Date - fairfax$YrBuilt
tmp <- diagnosticsPlot(fairfax, "lgPrice ~ Rooms + LndArea", pts_alpha = .75,
                       ln_size =  1.2, overall_title =
                         "Number of Rooms and Lot Size Predicting House Price")
ggsave(file.path(output_Path, "rr-05-fairfax-plot.png"), tmp[["Plot"]],
       height = 5.5, width = 12)
