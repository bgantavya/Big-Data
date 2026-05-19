# Initialization and setup

#' Initialize the image processing environment
#' Sets up ImageMagick limits, creates output folder, and loads required libraries
#' @return NULL (invisibly)
init_environment <- function() {
  # Set ImageMagick memory and resource limits
  Sys.setenv(MAGICK_MEMORY_LIMIT = MAGICK_MEMORY_LIMIT)
  Sys.setenv(MAGICK_DISK_LIMIT   = MAGICK_DISK_LIMIT)
  Sys.setenv(MAGICK_AREA_LIMIT   = MAGICK_AREA_LIMIT)
  Sys.setenv(MAGICK_MAP_LIMIT    = MAGICK_MAP_LIMIT)
  Sys.setenv(MAGICK_WIDTH_LIMIT  = MAGICK_WIDTH_LIMIT)
  Sys.setenv(MAGICK_HEIGHT_LIMIT = MAGICK_HEIGHT_LIMIT)

  # Load required packages
  if (!require("magick", quietly = TRUE)) {
    install.packages("magick")
    library(magick)
  }
  
  if (!require("tools", quietly = TRUE)) {
    install.packages("tools")
    library(tools)
  }

  # Create output folder if it doesn't exist
  if (!dir.exists(OUTPUT_FOLDER)) {
    dir.create(OUTPUT_FOLDER, recursive = TRUE)
  }

  invisible(NULL)
}
