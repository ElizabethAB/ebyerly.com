pkgs <- c("ggplot2", "MASS", "gridExtra", "animation", "grid", "stringr")
._ <- sapply(pkgs, library, character.only = TRUE)

set.seed(20160113)

summary(x <- rnorm(30, 50, 10))
summary(y <- x + rnorm(30, 0, 2))
x[1] <- 30
y[1] <- 80

df <- data.frame(x = x, y = y)
obj <- lm(x ~ y, df)
df$lm_resid <- obj$residuals
df$lm_pred <- obj$fitted.values

predicted <- 60

bs_anim <- function() {
  predictions <<- c()
  lapply(1:100, function(i) {
    print(i)
    df$bs_resid <- df$lm_resid[sample(nrow(df), replace = TRUE)]
    df$bs_x <- df$x + df$bs_resid

    obj <- lm(bs_x ~ y, df)
    df$bs_lm_resid <- obj$residuals

    prediction <<- as.numeric(predict(obj, newdata = data.frame(y = predicted)))
    predictions <<- c(prediction, predictions)

    sbpd <- data.frame(x = min(df$y), y = predictions)

    plt_bs <-   ggplot(df) +
      theme(axis.ticks = element_blank(),
            axis.text = element_blank(),
            axis.title = element_blank(),
            legend.position = "none") +
      xlim(min(df$y), max(df$y)) +
      ylim(min(c(df$x, df$lm_pred, df$rlm_pred)),
           max(c(df$x, df$lm_pred, df$rlm_pred))) +
      geom_abline(intercept = obj$coefficients["(Intercept)"],
                  slope = obj$coefficients["y"],
                  size=1, col = '#126180') +
      geom_vline(aes(xintercept = 60), linetype = "longdash", color = "#2de8bd") +
      geom_segment(aes(x = predicted, xend = min(df$y), y = prediction, yend = prediction),
                   color = "#2de8bd",
                   arrow = arrow(length = unit(.5, "cm"))) +
      geom_point(aes(y = x, x = y), size = 5, fill = '#e85f2d',
                 color = "black", shape = 21, alpha = .2) +
      geom_point(aes(x,y), data = sbpd, alpha = .05, shape = 45, size = 10) +
      geom_point(aes(x,y), data = sbpd[1,], color = "red", shape = 45, size = 10) +
      geom_point(aes(y = bs_x, x = y), size = 5, fill = '#e85f2d',
                 color = "black", shape = 21) +
      labs(x = "Prediction", y = "Predictor") +
      theme(axis.title = element_text(size = 20))

    plt_predictions <- ggplot(aes(x = preds),
                           data = data.frame(preds = predictions)) +
      geom_histogram(fill = "#126180") +
      geom_rug(color = '#e85f2d', alpha = .5) +
      geom_rug(aes(x = prediction), color = 'red', size = 1.2) +
      theme(axis.ticks = element_blank(),
            axis.text = element_blank(),
            axis.title = element_text(size = 20),
            legend.position = "none") +
      xlim(49, 59.5) +
      ylim(0, 15) +
      labs(x = "Prediction",
           y = "Count")

    tmp <- arrangeGrob(plt_predictions, plt_bs, ncol = 2,
                       top = textGrob(paste("Iteration",
                                            str_pad(i, 3, "0", side = "left")),
                                      gp = gpar(fontsize = 30,
                                                fontfamily = "mono")))
    grid.arrange(tmp)
  })
}

saveGIF(bs_anim(), interval = c(rep(1/10, 99), 4), clean = FALSE)
# saveHTML(bs_anim())
