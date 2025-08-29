###
# EDA
###

# Summarize data ====

func_summary_table <- function(data) {
  
  library(gtsummary)
  
  table_summary <- data %>%
    select(price, cut, color, clarity, carat) %>%
    gtsummary::tbl_summary(
      by = cut,
      statistic = list(
        all_continuous() ~ "{mean} ({sd})",
        all_categorical() ~ "{n} ({p}%)"  
      ),
      digits = all_continuous() ~ 2
    ) %>%
    gtsummary::modify_header(label ~ "**Variable**") %>%
    gtsummary::bold_labels()
  
  return(table_summary)
}

# EDA plots ====

# function to make plots
func_eda_plot <- function(data, variable) {
  
  library(ggplot2)
  var <- rlang::sym(variable)
  
  if (is.numeric(data[[variable]])) {
    p <- ggplot(data, aes(x = !!var, y = price)) +
      geom_point(alpha = 0.5)
  } else {
    p <- ggplot(data, aes(x = !!var, y = price)) +
      geom_boxplot(outlier.alpha = 0.1)
    
    p_final <- p + 
      theme_minimal(base_size = 14) +
      labs(
        x = variable,
        y = "price"
      )
    
    return(p_final)
  }
}

# function to combine plots
func_eda_plot_comb <- function(p1,p2,p3,p4) {
  
  library(patchwork)
  
  p <- (p1 + p2) / (p3 + p4)
}

