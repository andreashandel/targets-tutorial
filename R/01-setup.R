###
# 01 Setup
###

# Load and process data ====
func_process_data <- function() {
  
  # load data
  dat_raw <- ggplot2::diamonds
  
  # process data
  dat_processed <- dat_raw %>%
    mutate(
      # select most common cut/color/clarity is reference group
      cut = relevel(factor(cut, ordered = FALSE), ref = "Ideal"),
      color = relevel(factor(color, ordered = FALSE), ref = "G"),
      clarity = relevel(factor(clarity, ordered = FALSE), ref = "VS2")
    ) %>% 
    rename(
      depth_percent = depth,
      length_mm = x,
      width_mm = y,
      depth_mm = z
    )
  
  # return the dat_processed object
  return(dat_processed) 
}

