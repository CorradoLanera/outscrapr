# packages --------------------------------------------------------
use_package("httr")
use_package("jsonlite")
use_package("stringr")
use_package("checkmate")
use_package("purrr")
use_package("usethis")
use_tibble()

use_package("devtools", type = "Suggests")
use_package("testthat", type = "Suggests")
use_package("lintr", type = "Suggests")
use_package("withr", type = "Suggests")

use_tidy_description()


# functions -------------------------------------------------------
use_r("google_maps_search")

# tests -----------------------------------------------------------
