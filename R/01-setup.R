###
# 01 Setup
###

# Load and process data ====
func_process_data <- function() {
  
  # load data
  dat_raw <- ggplot2::diamonds
  
  # process data
  dat_processed <- dat_raw %>%
    rename(
      depth_percent = depth,
      length_mm = x,
      width_mm = y,
      depth_mm = z
    )
  
  # return the dat_processed object
  return(dat_processed) 
}

