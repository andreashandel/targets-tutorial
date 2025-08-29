###
# Fit model
###

# Fit gamma regression ====

func_fit_gamma_reg <- function(data) {
  
  mod_gamma <- glm(price ~ carats + cut + color + clarity,
                   data = data,
                   family = Gamma(link="log"))
  
  return(mod_gamma)
  
}
