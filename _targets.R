###
# _targets.R
###

# Setup ========================================================================

# load packages
library(targets)
library(tarchetypes) # extension package to targets

# number of cores to use
n_local_cores <- parallelly::availableCores(
  omit = 2,                   # omit = 2 keeps 2 cores free for other operations
  constraints = "connections" # avoids oversubscribing cores used by R connections
  )

# define crew controller for local workers
controller_local <- crew::crew_controller_local(
  name = "local",          # workers are just R processes on machine
  workers = n_local_cores, # number of workers to launch in parallel (n-2 from above)
  options_local = crew::crew_options_local(
    log_directory = "logs" # each worker writes a log file, useful for debugging
    )
  ## NOTE: if using github, include the logs/ folder in .gitignore 
)

# set target options
tar_option_set(
  format = "rds",                # save target results as .rds files by default
  controller = controller_local, # tell targets to use our crew controller
  resources = targets::tar_resources(
    crew = tar_resources_crew(
      controller = "local"       # associate pipeline with the "local" controller
      )
  ),
  packages = c("dplyr")          # packages that every worker loads automatically
)

# source custom functions
tar_source(
  files = list.files(
    "R",               # look inside the R/ folder
    pattern = "\\.R$", # only match .R files
    full.names = TRUE, # return full file paths
    recursive = FALSE  # don't look inside subfolders
    )
  )

# alternative: targets automatically sources all files located in the R/ folder
#tar_source()

# alternative: source a specific file or subfolder
#tar_source(here::here("R/common_functions"))

# Targets ======================================================================

list(
  ## 01 setup ====
  tar_target(
    name = process_data, # name of target
    command = func_process_data() # calls upon custom function
  ),
  
  ## 02 eda ====
  tar_target(
    summary_table, 
    func_summary_table(
      data=process_data
    )
  ),
  # eda plot: color
  tar_target(
    eda_plot_color,
    func_eda_plot(
      data=process_data,
      variable="color"
    )
  ),
  # eda plot: carat
  tar_target(
    eda_plot_carat,
    func_eda_plot(
      data=process_data,
      variable="carat"
    )
  ),
  # eda plot: cut
  tar_target(
    eda_plot_cut,
    func_eda_plot(
      data=process_data,
      variable="cut"
    )
  ),
  # eda plot: clarity
  tar_target(
    eda_plot_clarity,
    func_eda_plot(
      data=process_data,
      variable="clarity"
    )
  ),
  # combine eda plots
  tar_target(
    eda_plot_comb,
    func_eda_plot_comb(
      p1=eda_plot_color,
      p2=eda_plot_carat,
      p3=eda_plot_cut,
      p4=eda_plot_clarity
    )
  ),
  
  ## 03 model fits ====
  tar_target(
    fit_gamma_reg,
    func_fit_gamma_reg(
      data=process_data
    )
  )
)



