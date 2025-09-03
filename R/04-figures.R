###
# Figures
###

# Forest plot ====
func_fig_forest_plot <- function(mod, file_path, width, height) {
  
  library(ggplot2)
  library(patchwork)
  
  # extract tidy results
  dat <- broom::tidy(mod, conf.int = TRUE, exponentiate = TRUE) %>%
    filter(term != "(Intercept)") %>%
    mutate(
      term = factor(term, levels = rev(unique(term))),
      estimate_lab = sprintf("%.2f (%.2f, %.2f)", estimate, conf.low, conf.high)
    )
  
  # forest plot
  p_forest <- ggplot(dat, aes(x = estimate, y = term)) +
    geom_point(shape = 15, size = 3) +
    geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dashed", color = "gray50") +
    #scale_x_log10() +
    labs(
      title = "Gamma Regression Rate Ratios",
      x = "Rate Ratio (exp(coef))",
      y = NULL
    ) +
    theme_classic() +
    theme(
      plot.title = element_text(hjust = 0.5),
      axis.text.y = element_blank(),   # hide term names here
      axis.ticks.y = element_blank(),
      axis.line.y = element_blank()
    )
  
  # table of term names + estimates
  p_table <- ggplot(dat, aes(y = term)) +
    geom_text(aes(x = 0, label = term), hjust = 0, fontface = "bold") +
    geom_text(aes(x = 1, label = estimate_lab), hjust = 0) +
    theme_void() +
    coord_cartesian(xlim = c(0, 2))
  
  # combine using patchwork
  layout <- c(
    area(t = 0, l = 0, b = 20, r = 6),   # text labels
    area(t = 0, l = 6, b = 20, r = 12)   # forest plot
  )
  
  p <- p_table + p_forest + plot_layout(design = layout)
  
  # save to file
  ggsave(filename = file_path, plot = p, width = width, height = height)
  
  return(p)
}
