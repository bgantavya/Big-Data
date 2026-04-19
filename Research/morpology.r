# memory limts & imports

Sys.setenv(MAGICK_MEMORY_LIMIT = "8GiB")
Sys.setenv(MAGICK_DISK_LIMIT   = "15GiB")
Sys.setenv(MAGICK_AREA_LIMIT   = "4GiB")
Sys.setenv(MAGICK_MAP_LIMIT    = "4GiB")
Sys.setenv(MAGICK_WIDTH_LIMIT  = "50000")
Sys.setenv(MAGICK_HEIGHT_LIMIT = "50000")

install.packages("magick")
install.packages("ragg")

library(magick)
library(tools)

input_folder <- "./my_images"
output_folder <- "./output"

# Create output folder if it doesn't exist
if (!dir.exists(output_folder)) dir.create(output_folder, recursive = TRUE)


img_files <- list.files(
  path       = input_folder,
  pattern    = "\\.png$|\\.jpg$|\\.jpeg$|\\.tiff$|\\.bmp$",
  full.names = TRUE,
  recursive  = FALSE
)

cat("Found", length(img_files), "images\n")
if (length(img_files) == 0) stop("No images found — check your input folder path!")

target_width <- 5000 
output_format <- "png"
target_dpi <- 1200
contrast_passes <- 2
brightness      <- 105
saturation      <- 108
sharpen_strength <- 9    
layout_keyword <- "Layout"

build_output_path <- function(name) {
  file.path(output_folder, paste0(name, ".", output_format))
}

detect_type <- function(filename) {
  if (grepl(layout_keyword, filename, ignore.case = TRUE)) {
    return("layout")
  }
  return("schematic")
}

enhance_schematic <- function(img) {
  cat("    [Type: Schematic — minimal processing]\n")

  tryCatch({
    img <- image_despeckle(img)
    cat("    [1/1] Light denoise applied\n")
  }, error = function(e) {
    cat("    [1/1] Denoise skipped\n")
  })

  return(img)
}

enhance_layout <- function(img) {
  cat("    [Type: Layout — color preserved]\n")

  # STEP 1: removes dot noise without touching colors
  tryCatch({
    img <- image_despeckle(img)
    cat("    [1/3] Denoised\n")
  }, error = function(e) {
    cat("    [1/3] Denoise skipped\n")
  })

  # STEP 2: Makes red/blue/green lines more vivid and distinct
  tryCatch({
    img <- image_normalize(img)
    cat("    [2/3] Normalized\n")
  }, error = function(e) {
    cat("    [2/3] Normalize skipped\n")
  })

  # STEP 3: Gentle sharpen — sharpens colored line boundaries
  tryCatch({
    sharpen_matrix <- matrix(c(
       0, -1,  0,
      -1,  5, -1,
       0, -1,  0
    ), nrow = 3, byrow = TRUE)
    img <- image_convolve(img, sharpen_matrix)
    cat("    [3/3] Sharpened\n")
  }, error = function(e) {
    cat("    [3/3] Sharpen skipped\n")
  })

  return(img)
}

enhance_image <- function(img, nm) {
  cat("  Enhancing...\n")

  # STEP 1: removes grain and small pixel noise
  img <- image_despeckle(img)
  cat("    [1/7] Denoised\n")

  # STEP 2: auto-stretches histogram, fixes dull/dark images
  img <- image_normalize(img)
  cat("    [2/7] Normalized\n")

  # STEP 3: multiple passes for stronger effect
  for (i in seq_len(contrast_passes)) {
    img <- image_contrast(img)
  }
  cat("    [3/7] Contrast boosted (", contrast_passes, "passes)\n")

  # STEP 4: Brightness and saturation adjustment
  img <- image_modulate(img, brightness = brightness, saturation = saturation)
  cat("    [4/7] Brightness/Saturation adjusted\n")

  # STEP 5: Morphological OPEN — removes small noise dots outside lines
  tryCatch({
    img <- image_morphology(img, method = "Open", kernel = "Disk:1")
    cat("    [5/7] Morphological open applied\n")
  }, error = function(e) {
    cat("    [5/7] Morphological open skipped:", conditionMessage(e), "\n")
  })

  # STEP 6: Sharpen using convolution matrix
  tryCatch({
    center <- sharpen_strength
    edge   <- -1
    corner <- -1
    sharpen_matrix <- matrix(c(
      corner, edge,   corner,
      edge,   center, edge,
      corner, edge,   corner
    ), nrow = 3, byrow = TRUE)
    img <- image_convolve(img, sharpen_matrix)
    cat("    [6/7] Sharpened (strength:", sharpen_strength, ")\n")
  }, error = function(e) {
    cat("    [6/7] Sharpen skipped:", conditionMessage(e), "\n")
  })

  # STEP 7: makes blacks blacker, whites whiter
  tryCatch({
    img <- image_level(img, black = 2, white = 98)
    cat("    [7/7] Level stretch applied\n")
  }, error = function(e) {
    cat("    [7/7] Level stretch skipped:", conditionMessage(e), "\n")
  })

  return(img)
}

process_image <- function(img_path, use_type_detection = FALSE, resize_mode = c("scale", "resize")) {
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
      img <- image_scale(img, as.character(target_width))
    } else {
      img <- image_resize(img,
                          geometry = as.character(target_width),
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
    image_write(img, path = out_path, format = output_format, density = target_dpi)
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

cat("\n--- Processing Images ---\n")
success_count <- 0
skip_count    <- 0

for (img_path in img_files) {
  process_image(img_path, use_type_detection = FALSE, resize_mode = "scale")
}

for (img_path in img_files) {

  nm   <- file_path_sans_ext(basename(img_path))
  type <- detect_type(nm)

  cat("\n[", which(img_files == img_path), "/", length(img_files), "]",
      "Processing:", nm, "| Type:", type, "\n")

  tryCatch({

    # LOAD
    img  <- image_read(img_path)
    info <- image_info(img)
    cat("  Original size:", info$width, "x", info$height, "\n")

    # RESIZE with Lanczos — best for both types
    img      <- image_resize(img,
                             geometry = as.character(target_width),
                             filter   = "Lanczos")
    info_new <- image_info(img)
    cat("  Resized to:  ", info_new$width, "x", info_new$height, "\n")

    # ENHANCE based on type
    if (type == "layout") {
      img <- enhance_layout(img)
    } else {
      img <- enhance_schematic(img)
    }

    # SAVE
    out_path <- build_output_path(nm)
    image_write(img, path = out_path, format = output_format, density = target_dpi)
    cat("  Saved:", out_path, "\n")

    success_count <- success_count + 1

  }, error = function(e) {
    cat("  SKIPPED (error):", conditionMessage(e), "\n")
    skip_count <<- skip_count + 1
  })

  if (exists("img")) rm(img)
  gc()
}

# sumup
cat("\n============================================================\n")
cat("Done!\n")
cat("  Processed successfully:", success_count, "images\n")
cat("  Skipped (errors):      ", skip_count,    "images\n")
cat("  Output folder:         ", output_folder,  "\n")
cat("============================================================\n")


