# Main entry point for image processing pipeline

# Determine base directory (Research folder where main.r is located)
SCRIPT_BASE_DIR <<- tryCatch(
  {
    script_path <- sys.frame(1)$ofile
    if (is.null(script_path) || script_path == "") {
      getwd()
    } else {
      dirname(script_path)
    }
  },
  error = function(e) getwd()
)

# Source all module files from src/ subdirectory
source(file.path(SCRIPT_BASE_DIR, "src", "constants.r"))
source(file.path(SCRIPT_BASE_DIR, "src", "init.r"))
source(file.path(SCRIPT_BASE_DIR, "src", "utils.r"))
source(file.path(SCRIPT_BASE_DIR, "src", "enhance.r"))
source(file.path(SCRIPT_BASE_DIR, "src", "process.r"))

init_environment()

img_files <- get_image_files()
validate_image_files(img_files)

cat("\n--- Processing Images ---\n")
success_count <- 0
skip_count    <- 0

cat("\n=== PASS 1: Scale-based Processing ===\n")
for (img_path in img_files) {
  process_image(img_path, img_files, use_type_detection = FALSE, resize_mode = "scale")
}

cat("\n=== PASS 2: Type-aware Processing ===\n")
for (img_path in img_files) {
  process_image(img_path, img_files, use_type_detection = TRUE, resize_mode = "resize")
}

# Print summary report
cat("\n============================================================\n")
cat("Done!\n")
cat("  Processed successfully:", success_count, "images\n")
cat("  Skipped (errors):      ", skip_count,    "images\n")
cat("  Output folder:         ", OUTPUT_FOLDER,  "\n")
cat("============================================================\n")
