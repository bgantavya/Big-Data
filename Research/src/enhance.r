# Image enhancement functions

#' Enhance schematic images (minimal processing)
#' @param img Image object from magick
#' @return Enhanced image
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

#' Enhance layout images (color-preserving processing)
#' @param img Image object from magick
#' @return Enhanced image
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

#' Enhance image with full 7-step pipeline
#' @param img Image object from magick
#' @param nm Name/label for the image
#' @return Enhanced image
enhance_image <- function(img, nm) {
  cat("  Enhancing...\n")

  # STEP 1: removes grain and small pixel noise
  img <- image_despeckle(img)
  cat("    [1/7] Denoised\n")

  # STEP 2: auto-stretches histogram, fixes dull/dark images
  img <- image_normalize(img)
  cat("    [2/7] Normalized\n")

  # STEP 3: multiple passes for stronger effect
  for (i in seq_len(CONTRAST_PASSES)) {
    img <- image_contrast(img)
  }
  cat("    [3/7] Contrast boosted (", CONTRAST_PASSES, "passes)\n")

  # STEP 4: Brightness and saturation adjustment
  img <- image_modulate(img, brightness = BRIGHTNESS, saturation = SATURATION)
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
    center <- SHARPEN_STRENGTH
    edge   <- -1
    corner <- -1
    sharpen_matrix <- matrix(c(
      corner, edge,   corner,
      edge,   center, edge,
      corner, edge,   corner
    ), nrow = 3, byrow = TRUE)
    img <- image_convolve(img, sharpen_matrix)
    cat("    [6/7] Sharpened (strength:", SHARPEN_STRENGTH, ")\n")
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
