#!/usr/bin/env Rscript
# ============================================================================
# WFP Bootswatch Theme - Installation Test Script
# ============================================================================
# Run this script to verify the theme is working correctly.
# ============================================================================

cat("========================================\n")
cat("WFP Bootswatch Theme - Installation Test\n")
cat("========================================\n\n")

# Check dependencies
cat("Checking dependencies...\n")
required_pkgs <- c("shiny", "bslib", "sass", "htmltools")
missing <- character()
for (pkg in required_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    missing <- c(missing, pkg)
    cat(sprintf("  [MISSING] %s\n", pkg))
  } else {
    ver <- packageVersion(pkg)
    cat(sprintf("  [OK] %s (v%s)\n", pkg, ver))
  }
}

if (length(missing) > 0) {
  cat(sprintf("\nPlease install missing packages:\n  install.packages(c(%s))\n",
      paste0("'", missing, "'", collapse = ", ")))
  quit(status = 1)
}

# Load the package
cat("\nLoading wfp.bootswatch...\n")
library(wfp.bootswatch)
cat("  [OK] Package loaded successfully\n")

# Test wfp_color_palette()
cat("\nTesting wfp_color_palette()...\n")
palette <- wfp_color_palette()
expected_colors <- c("primary", "secondary", "navy", "aqua", "success",
                     "warning", "danger", "light", "dark")
for (col in expected_colors) {
  if (col %in% names(palette)) {
    cat(sprintf("  [OK] %s = %s\n", col, palette[[col]]))
  } else {
    cat(sprintf("  [MISSING] %s not found\n", col))
  }
}

# Test wfp_font()
cat("\nTesting wfp_font()...\n")
fonts <- wfp_font()
cat(sprintf("  [OK] Base font: %s...\n", substr(fonts$base, 1, 50)))
cat(sprintf("  [OK] Code font: %s...\n", substr(fonts$code, 1, 50)))

# Test wfp_theme() - create theme without errors
cat("\nTesting wfp_theme()...\n")
tryCatch({
  theme <- wfp_theme()
  if (inherits(theme, "bs_theme")) {
    cat("  [OK] Theme created successfully (bs_theme object)\n")
  } else {
    cat("  [ISSUE] Theme object is not a bs_theme\n")
  }
}, error = function(e) {
  cat(sprintf("  [ERROR] %s\n", e$message))
})

# Test with custom colors
cat("\nTesting wfp_theme() with custom colors...\n")
tryCatch({
  theme2 <- wfp_theme(
    primary = "#0A6EB4",
    font_scale = 1.1
  )
  if (inherits(theme2, "bs_theme")) {
    cat("  [OK] Custom theme created successfully\n")
  } else {
    cat("  [ISSUE] Custom theme object is not a bs_theme\n")
  }
}, error = function(e) {
  cat(sprintf("  [ERROR] %s\n", e$message))
})

cat("\n========================================\n")
cat("All tests completed!\n")
cat("========================================\n")
cat("\nTo run the demo app:\n")
cat("  shiny::runApp(system.file('examples', 'demo-app.R', package = 'wfp.bootswatch'))\n")
