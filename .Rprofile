options(tidyverse.quiet = TRUE)

if (
  interactive() &&
  requireNamespace("usethis", quietly = TRUE) &&
  (
    as.logical(Sys.getenv("ATTACH_STARTUP_PKGS", FALSE)) ||
    usethis::ui_yeah(
      "Would you like to attachdevelopment supporting packages"
    )
  )
) {
  .attach <- function(pkg) {
    if (requireNamespace(pkg, quietly = TRUE)) {
      pkg |>
        library(character.only = TRUE) |>
        suppressWarnings() |>
        suppressPackageStartupMessages()
      usethis::ui_done("Package {ui_value(pkg)} attached.")
    }
  }
  usethis::ui_todo("Attaching development supporting packages...")
  .attach("usethis")
  .attach("devtools")
  .attach("testthat")
  .attach("checkmate")
}
