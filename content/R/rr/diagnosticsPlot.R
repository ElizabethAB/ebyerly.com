diagnosticsPlot <- function(df, specification, overall_title = '',
                            pts_alpha = 1, ln_size = 1, dot_size = 1,
                            my_blue = "#126180", my_grey = "#6d6e71") {
  linear.model <- lm(specification, data = df)
  df <- df[complete.cases(df[,names(linear.model$model)]),]

  df$Leverage <- influence(linear.model)$hat
  df$Fitted <- linear.model$fitted
  df$Residual <- linear.model$residuals
  df$StandResidual <- rstandard(linear.model)
  df$StudResidual <- studres(linear.model)
  df$CooksD <- cooks.distance(linear.model)
  df$CooksFlag <- df$CooksD > 1

  base <- ggplot(data = df) +
    theme(plot.title = element_text(size = rel(1.2), face = 'bold'))

  # Fitted values v. standardized residual
  one <- base +
    geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.5) +
    geom_point(aes(x = Fitted, y = StudResidual), col = my_blue,
               size = dot_size, alpha = pts_alpha) +
    geom_smooth(aes(x = Fitted, y = StudResidual), se=FALSE, col = my_grey,
                size = ln_size, alpha = pts_alpha) +
    labs(title = "Studentized Residuals v. Fitted Values",
         y = "Studentized Residual", x = "Fitted Value")

  # Root standardized residual against fitted value
  two <- base +
    geom_point(aes(Fitted, sqrt(abs(StudResidual))), col = my_blue,
               size = dot_size, alpha = pts_alpha) +
    geom_smooth(aes(Fitted, sqrt(abs(StudResidual))), se=FALSE,
                col = my_grey, size = ln_size, alpha = pts_alpha) +
    labs(title = "Scale-Location Comparison",
         y = "Root Stud. Residuals", x = "Fitted Values")

  # QQ plot of standardized residuals
  a <- quantile(df$StudResidual, c(0.25, 0.75))
  b <- qnorm(c(0.25, 0.75))
  slope <- diff(a)/diff(b)
  int <- a[1] - slope * b[1]
  three <- base +
    geom_abline(intercept = int, slope = slope, col = my_grey, size = ln_size,
                alpha = pts_alpha) +
    stat_qq(aes(sample = StudResidual), col = my_blue, size = dot_size,
            alpha = pts_alpha) +
    labs(title = "Normal QQ Plot of Studentized Residuals",
         y = "Sample", x = "Theoretical")

  # Cook's Distance v. Leverage
  four <- base +
    geom_point(aes(x = Leverage, y = CooksD), col = my_blue, size = dot_size,
               alpha = pts_alpha) +
    geom_smooth(aes(x = Leverage, y = CooksD), se=FALSE, col = my_grey,
                size = ln_size, alpha = pts_alpha) +
    labs(title = "Cook's Distance v. Leverage",
         y = "Cook's Distance", x = "Leverage")

  tst <- arrangeGrob(one, two, three, four, ncol = 2,
                     top = textGrob(paste0(overall_title, "\n"), vjust = 1,
                                    gp = gpar(fontface = "bold", cex = 1.5)))
  list("Plot" = tst, "Dataframe" = df)
}
