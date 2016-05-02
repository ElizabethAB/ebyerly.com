setwd(".")

rm(list = ls())
sink()

output_Path <- file.path("Outputs", Sys.Date())
dir.create(output_Path, recursive = TRUE)

sink(file.path(output_Path, "Log File.txt"), append = FALSE, split = TRUE)


mySource <- function(fn) source(fn, echo = TRUE, max.deparse.length = 1e9)

mySource("01-environment.R")
mySource("02-anscombe.R")
mySource("03-objective-psi-weight-functions.R")
mySource("04-outliers-leverage-influence.R")
mySource("05-diagnostics-plots.R")
mySource("06-breakdown-point.R")
mySource("07-multiple-relationships.R")


sink()
