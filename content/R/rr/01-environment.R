pkgs <- c("ggplot2", "grid", "gridExtra", "reshape2", "MASS", "robustbase")
._ <- sapply(pkgs, library, character.only = TRUE, quietly = TRUE)

set.seed(20150302)

empty_theme <-  theme(line = element_blank(),
                      rect = element_blank(),
                      text = element_blank(),
                      title = element_blank())

windowsFonts(Arial=windowsFont("TT Arial"))

type_base <-  function(expr, sz = 1, parse = TRUE) {
  ggplot(data.frame(x = 0, y = 0), aes(x = x, y = y), color = white) +
    empty_theme +
    annotate("text", x = 0, y = 0, label = expr, parse = parse, size = sz,
             fontface = 'bold', family = 'Arial')
}

my_blue <- "#126180"
my_orange <- "#fd4e0b"
my_grey <- "#6d6e71"

mySource("diagnosticsPlot.R")

sessionInfo()
