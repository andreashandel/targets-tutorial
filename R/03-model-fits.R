###
# Fit model
###

# Fit gamma regression ====

func_fit_gamma_reg <- function(data) {
  
  browser()
  
  mod_gamma <- glm(price ~ carat + cut + color + clarity,
                   data = data,
                   family = Gamma(link="log"))
  
  return(mod_gamma)
  
}
