ls_rho <- function(x) x^2
ls_psi <- function(x) x
ls_weight <- function(x) 1

huber_rho <- function(x, k = 1.345) {
  ifelse(abs(x) <= k,
         0.5*x^2,
         k*abs(x) - 0.5*k^2)
}
huber_psi <- function(x, k = 1.345) {
  ifelse (abs(x) <= k,
          x,
          k * sign(x))
}
huber_weight <-  function(x, k = 1.345) {
  ifelse(abs(x) <= k,
         1,
         k/abs(x))
}

bisquare_rho <- function(x, k = 4.685) {
  ifelse(abs(x) <= k,
         (k^2/6)*(1 - (1 - (x/k)^2)^3),
         k^2/6)
}
bisquare_psi <- function(x, k = 4.685) {
  ifelse(abs(x) <= k,
         x*(1 - (x/k)^2)^2,
         0)
}
bisquare_weight <- function(x, k = 4.685) {
  ifelse(abs(x) <= k,
         (1 - (x/k)^2)^2,
         0)
}

################################################################################

base <- ggplot(data.frame(x = c(-6, 6)), aes(x)) +
  labs(x = '', y = '') +
  xlim(-6, 6) +
  theme(panel.grid.minor = element_blank())

mystat <- function(fun) {
  stat_function(fun = fun, color = my_blue, size = 1.1)
}

symbol_size <- 8
method_size <- 7

################################################################################

ls_rho_p <- base + mystat(ls_rho)
huber_rho_p <- base + mystat(huber_rho)
bisquare_rho_p <- base + mystat(bisquare_rho)

ls_psi_p <- base + mystat(ls_psi)
huber_psi_p <- base + mystat(huber_psi)
bisquare_psi_p <- base + mystat(bisquare_psi)

ls_weight_p <- base + mystat(ls_weight)
huber_weight_p <- base + mystat(huber_weight)
bisquare_weight_p <- base + mystat(bisquare_weight)

################################################################################

functions <-
  arrangeGrob(type_base("", 0), type_base("rho(e)", symbol_size),
              type_base("psi(e)", symbol_size),
              type_base("wgt(e)", symbol_size),
              type_base("OLS", method_size), ls_rho_p, ls_psi_p, ls_weight_p,
              type_base("Huber", method_size), huber_rho_p, huber_psi_p,
              huber_weight_p,
              type_base("Tukey", method_size), bisquare_rho_p, bisquare_psi_p,
              bisquare_weight_p,
              ncol = 4, heights = c(2,4,4,4), widths = c(1,2,2,2))

ggsave(file.path(output_Path, "rr-03-objective-psi-weight-functions.png"),
       functions, width = 12, height = 6)


func_names <- arrangeGrob(type_base("OLS", method_size),
                          type_base("Huber", method_size),
                          type_base("Tukey", method_size),
                          ncol = 3)
weights <- arrangeGrob(ls_weight_p, huber_weight_p, bisquare_weight_p, ncol = 3)
weight_p <- arrangeGrob(func_names, weights, ncol = 1, heights = c(2, 10))

ggsave(file.path(output_Path, "rr-03-weight-functions.png"),
       weight_p, width = 16, height = 5)
