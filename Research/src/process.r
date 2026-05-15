# Image processing logic

#' Process a single image with selected enhancement path
#' @param img_path Path to the image file
#' @param img_files Vector of all image files (for indexing)
#' @param use_type_detection Whether to use type-aware enhancement
#' @param resize_mode Either "scale" or "resize" (with Lanczos filter)
#' @param success_count Current count of successful processes (modified in parent env)
#' @param skip_count Current count of skipped processes (modified in parent env)
process_image <- function(img_path, img_files, use_type_detection = FALSE, 
                          resize_mode = c("scale", "resize")) {
  resize_mode <- match.arg(resize_mode)
  nm <- file_path_sans_ext(basename(img_path))

  if (use_type_detection) {
    type <- detect_type(nm)
    cat("\n[", which(img_files == img_path), "/", length(img_files), "]",
        "Processing:", nm, "| Type:", type, "\n")
  } else {
    cat("\n[", which(img_files == img_path), "/", length(img_files), "]",
        "Processing:", nm, "\n")
  }

  tryCatch({
    img  <- image_read(img_path)
    info <- image_info(img)
    cat("  Original size:", info$width, "x", info$height, "\n")

    if (resize_mode == "scale") {
      img <- image_scale(img, as.character(TARGET_WIDTH))
    } else {
      img <- image_resize(img,
                          geometry = as.character(TARGET_WIDTH),
                          filter   = "Lanczos")
    }

    info_new <- image_info(img)
    cat("  Resized to:  ", info_new$width, "x", info_new$height, "\n")

    if (use_type_detection) {
      if (detect_type(nm) == "layout") {
        img <- enhance_layout(img)
      } else {
        img <- enhance_schematic(img)
      }
    } else {
      img <- enhance_image(img, nm)
    }

    out_path <- build_output_path(nm)
    image_write(img, path = out_path, format = OUTPUT_FORMAT, density = TARGET_DPI)
    cat("  Saved:", out_path, "\n")

    success_count <<- success_count + 1
    TRUE

  }, error = function(e) {
    cat("  SKIPPED (error):", conditionMessage(e), "\n")
    skip_count <<- skip_count + 1
    FALSE
  })

  if (exists("img")) rm(img)
  gc()
}
