# Utility functions for image processing

#' Build output file path
#' @param name Base name of the file
#' @return Full path for output file
build_output_path <- function(name) {
  file.path(OUTPUT_FOLDER, paste0(name, ".", OUTPUT_FORMAT))
}

#' Detect image type based on filename
#' @param filename Name of the image file
#' @return Either "layout" or "schematic"
detect_type <- function(filename) {
  if (grepl(LAYOUT_KEYWORD, filename, ignore.case = TRUE)) {
    return("layout")
  }
  return("schematic")
}

#' Get file list from input folder
#' @return Vector of image file paths
get_image_files <- function() {
  list.files(
    path       = INPUT_FOLDER,
    pattern    = "\\.png$|\\.jpg$|\\.jpeg$|\\.tiff$|\\.bmp$",
    full.names = TRUE,
    recursive  = FALSE
  )
}

#' Validate that images were found
#' @param img_files Vector of image paths
validate_image_files <- function(img_files) {
  if (length(img_files) == 0) {
    stop("No images found — check your input folder path!")
  }
  cat("Found", length(img_files), "images\n")
}
